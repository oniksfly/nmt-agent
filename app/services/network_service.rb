class NetworkService
  include HTTParty
  base_uri Rails.configuration.remote_backend_url

  def initialize
    # TODO: Set token value
    @token = nil
  end

  def user_torrents_list
    self.class.get('/public/torrent_user_uploads')
  end

end