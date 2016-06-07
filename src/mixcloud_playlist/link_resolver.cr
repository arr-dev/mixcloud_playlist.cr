require "http/client"

module MixcloudPlaylist
  class LinkResolver
    def initialize(@url : String)
      @count = 0
    end

    def resolve
      resolve_url(@url)
    end

    private def resolve_url(url)
      response = HTTP::Client.head(url)

      case response.status_code
      when 200
        url
      when 302
        location = response.headers["Location"]
        if location.starts_with?("/")
          uri = URI.parse(url)
          resolve_url("#{uri.scheme}://#{uri.host}#{location}")
        else
          resolve_url(location)
        end
      else
        puts "ERROR:"
        puts url
        puts response.status_code
        exit
      end
    end
  end
end
