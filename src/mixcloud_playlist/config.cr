require "yaml"

module MixcloudPlaylist
  class Config
    class PathResolver
      def self.from_yaml(pull : YAML::PullParser)
        path = pull.read_scalar

        File.expand_path(path)
      end
    end

    getter links : (Array(String))?

    YAML.mapping({
      access_token: String,
      links_path: {
        type: String,
        converter: PathResolver,
      }
    })

    def self.load(path) : self
      from_yaml(File.read(path))
    end

    def initialize(attributes)
      @access_token = attributes[:access_token]
      @links_path = File.expand_path(attributes[:links_path])
    end

    def links
      @links ||= File.read_lines(links_path).map(&.strip)
    end
  end
end
