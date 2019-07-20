class NetworkService
  include HTTParty
  base_uri Rails.configuration.remote_backend_url

  def initialize(token)
    @token = token

    self.class.headers 'Authorization-Entity' =>  'local_agent'
    self.class.headers 'Authorization' => @token
  end

  def user_torrents_list
    self.class.get('/public/torrent_user_uploads')
  end

end