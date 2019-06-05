class Preference < ApplicationRecord

  # Define if preference should be uniq
  # Prevent of changing keys order
  KINDS = {
    local_token: true,
    server_token: true
  }.freeze

  enum kind: KINDS.keys

  validates_presence_of :kind
  validates_uniqueness_of :kind, if: -> (i){ KINDS[i] }

  class << self
    Preference::KINDS.select{ |_, v| v }.keys.each do |method_name|
      define_method("get_#{method_name}") { send(method_name).try(:first).try(:value) }
      define_method("set_#{method_name}") { |argument| attribute_set_value(method_name, argument) }
    end

    private

    # @param attribute_name [Symbol]
    def attribute_set_value(attribute_name, attribute_value = nil)
      raise ArgumentError unless KINDS.keys.include?(attribute_name)

      if KINDS[attribute_name]
        Preference.where(kind: attribute_name).first_or_initialize.tap do |preference|
          preference.name = attribute_name
          preference.kind = attribute_name
          preference.value = attribute_value
          preference.unique = true
          preference.save
        end
      end
    end
  end
end
