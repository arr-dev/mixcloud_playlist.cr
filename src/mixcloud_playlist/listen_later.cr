require "json"

module MixcloudPlaylist
  class ListenLater
    property :access_token

    def initialize(@access_token : String)
    end

    def add(url : String) : Bool
      path = cloudcast_path(url)

      response = HTTP::Client.post("#{API_HOST}#{path}/listen-later/?access_token=#{access_token}")

      if response.status_code == 200
        j = JSON.parse(response.body)

        j["result"]["success"] == true
      else
        false
      end
    end

    private def cloudcast_path(url)
      URI.parse(url).path
    end
  end
end

