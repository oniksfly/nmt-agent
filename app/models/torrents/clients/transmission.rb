require 'transmission'

module Torrents
  module Clients
    class Transmission < Client

      def type_name
        'Transmission'
      end

      def list_all_torrents
        torrents = Transmission::Model::Torrent.all
        puts torrents.inspect
      end
    end
  end
end