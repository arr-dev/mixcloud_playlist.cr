require "../spec_helper"
require "../../src/mixcloud_playlist/cli"

describe MixcloudPlaylist::Cli, ".run" do
  it "adds urls from file passed in config" do
    body = {
      result: {
        success: true,
        message: "Added to listen later: name"
      }
    }
    WebMock.stub(:head, "mx.com/").
      to_return(status: 200)
    WebMock.stub(:head, "mx1.com/").
      to_return(status: 200)
    WebMock.stub(:post, "api.mixcloud.com/listen-later/?access_token=TOKEN").
      to_return(body: body.to_json)
    MixcloudPlaylist::Cli.run(["spec/fixtures/config.yml"]).should eq(2)
  end

  it "gives error when no file is given" do
    MixcloudPlaylist::Cli.run([] of String).should be_false
  end
end
