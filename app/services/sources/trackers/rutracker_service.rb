module Sources
  module Trackers
    class Rutracker
      extend Service

      attr_accessor :url, :proxy_settings
    end
  end
end