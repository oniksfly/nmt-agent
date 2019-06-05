require 'net/http'

class Proxy < ApplicationRecord
  TYPES = { http: 0, https: 1 }
  DEFAULT_TEST_URL = 'https://nmt.pw'

  enum kind:TYPES

  attr_accessor :connection

  validates_presence_of :server_host, :server_port
  validates_uniqueness_of  :server_host, scope: [:server_port, :username]

  def name
    if username.present?
      "#{username}@#{server_host}:#{server_port}"
    else
      "#{server_host}:#{server_port}"
    end
  end

  def test_connection(url = DEFAULT_TEST_URL, redirections = 5)
    return false if redirections <= 0

    uri = URI.parse(url)
    connection_wrapper(uri) do |http, error|
      return false if error.present?

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      case response
      when Net::HTTPSuccess
        return true
      when Net::HTTPRedirection 
        test_connection(response['location'], redirections - 1)
      when Net::OpenTimeout
        false
      else
        false
      end
    end

    false
  end

  # @param uri [URI]
  def connection_wrapper(uri)
    http_session = Net::HTTP.new(uri.host, uri.port, server_host, server_port, username, password)
    http_session.use_ssl = uri.instance_of? URI::HTTPS
    begin
      http_session.start{ |http| yield(http, nil) }  
    rescue => exception
      yield(nil, exception)
    end
  end
end
