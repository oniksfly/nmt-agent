require 'transmission'

module Torrents
  module Clients
    class Transmission < Client

      attr_accessor :rpc

      def type_name
        'Transmission'
      end

      def connection
        if @rpc.present?
          @rpc
        else
          params = { host: host, port: port, ssl: false }
          params[:path] = path if path.present?
          if username.present?
            params[:credentials] = { username: username }
            params[:credentials][:password] = password if password.present?
          end

          @rpc = ::Transmission::RPC.new(params)
        end
      end

      def available?
        begin
          connection.get_session.try(:[], 'version').present?
        rescue => exception
          false
        end
      end
    end
  end
end