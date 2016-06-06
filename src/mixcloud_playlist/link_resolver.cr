module MixcloudPlaylist
  class LinkResolver
    def initialize(@url : String)
    end

    def resolve
      resolve_url(@url)
    end

    private def resolve_url(url)
      response = HTTP::Client.get(url)

      case response.status_code
      when 200
        url
      when 302
        url = response.headers["Location"]
        resolve_url(url)
      else
        puts "ERROR:"
        puts url
        puts response.status_code
        exit
      end
    end
  end
end
