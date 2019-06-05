class RemoteAccountService
  extend Service

  SERVER_TOKEN_PATTERN = /\A[a-z0-9_\-]+\z/i

  attr_accessor :local_token, :server_token, :errors

  def call
    self.errors = {}
    self.local_token = get_local_token!
    self.server_token = Preference.get_server_token

    self
  end

  def initialized?
    server_token.present?
  end

  # Check validation errors for attribute
  # @param attribute [Symbol]
  #
  # @return [Boolean]
  def form_attribute_valid?(attribute)
    return unless respond_to?(attribute)

    errors[attribute].blank?
  end

  # Check if it possible to process server request
  #
  # @return [Boolean] true if possible
  def update_and_validate(server_token: nil)
    self.server_token = server_token if server_token.present?

    validate

    errors.blank?
  end

  def validate
    if server_token.blank?
      self.errors[:server_token] = 'Server token is blank'
    end

    unless SERVER_TOKEN_PATTERN.match(server_token).present?
      self.errors[:server_token] = 'Wrong token format'
    end
  end

  def register_server_token
    if server_token.blank? or SERVER_TOKEN_PATTERN.match(server_token).blank?
      return
    end

    Preference.set_server_token(server_token)
  end

  private
  def get_local_token!
    local_token = Preference.get_local_token
    if local_token.present?
      local_token
    else
      token = "#{SecureRandom.base58(8)}#{Time.current.to_i}#{SecureRandom.base58(8)}"
      key = SecureRandom.random_bytes(32)
      crypt = ActiveSupport::MessageEncryptor.new(key)
      encrypted_token = crypt.encrypt_and_sign(token)
      Preference.set_local_token(encrypted_token.gsub(/[^a-z0-9]/i, ''))
      encrypted_token
    end
  end
end