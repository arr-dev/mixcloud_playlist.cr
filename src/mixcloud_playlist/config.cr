require "yaml"

module MixcloudPlaylist
  class Config
    getter links : (Array(String))?

    YAML.mapping({
      sid: String,
      csrftoken: String,
      playlist_name: String,
      links_path: String
    })

    def self.load(path) : self
      from_yaml(File.read(path)).tap do |c|
        c.load_links
      end
    end

    def initialize(attributes)
      @sid = attributes[:sid]
      @csrftoken = attributes[:csrftoken]
      @playlist_name = attributes[:playlist_name]
      @links_path = attributes[:links_path]
    end

    def load_links
      @links = File.read_lines(links_path).map(&.strip)
    end
  end
end
