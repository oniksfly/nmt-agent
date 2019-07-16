module API
  class RemoteTorrentsService
    extend Service

    attr_accessor :remote_torrents

    def call
      self.remote_torrents = []

      self
    end

    def get_remote_torrents_list
      # TODO: implement
    end
  end
end