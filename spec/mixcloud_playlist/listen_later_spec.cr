require "../spec_helper"
require "../../src/mixcloud_playlist/listen_later"
require "json"

describe MixcloudPlaylist::ListenLater do
  it "adds cloudcast to listen later playlist" do
    body = {
      result: {
        success: true,
        message: "Added to listen later: name"
      }
    }
    WebMock.stub(:post, "api.mixcloud.com/author/name/listen-later/").
      with(query: {"access_token": "TOKEN"}).
      to_return(status: 200, body: body.to_json)

    later = MixcloudPlaylist::ListenLater.new("TOKEN")

    later.add("https://www.mixcloud.com/author/name").should be_true
  end
end
