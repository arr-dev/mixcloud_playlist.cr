module MixcloudPlaylist
  class LoginVerifier
    def initialize(@sessionid : String)
    end

    def valid?
      response = HTTP::Client.get(
        MixcloudPlaylist::HOST,
        headers: HTTP::Headers{"Cookie": "s=#{@sessionid}"}
      )

      response.status_code == 200 && valid_body?(response.body)
    end

    private def valid_body?(body)
      body.includes?(%q{_loggedIn": true})
    end
  end
end
