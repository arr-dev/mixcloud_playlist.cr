require "yaml"

module MixcloudPlaylist
  class Config
    getter links : (Array(String))?

    YAML.mapping({
      access_token: String,
      links_path: String
    })

    def self.load(path) : self
      from_yaml(File.read(path))
    end

    def initialize(attributes)
      @access_token = attributes[:access_token]
      @links_path = attributes[:links_path]
    end

    def links
      @links ||= File.read_lines(links_path).map(&.strip)
    end
  end
end
