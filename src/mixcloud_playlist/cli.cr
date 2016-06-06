module MixcloudPlaylist
  class Cli
    def self.run(args)
      config = Config.load(args[0])

      listen_later = ListenLater.new(config.access_token)

      config.links.count do |link|
        listen_later.add(LinkResolver.new(link).resolve)
      end
    end
  end
end
