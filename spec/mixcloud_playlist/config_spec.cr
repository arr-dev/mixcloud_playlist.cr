require "../spec_helper"
require "../../src/mixcloud_playlist/config"

describe MixcloudPlaylist::Config, ".load" do
  it "loads config from yml" do
    config = MixcloudPlaylist::Config.load("spec/fixtures/config.yml")
    config.sid.should eq("sessionid")
    config.csrftoken.should eq("csrf")
    config.playlist_name.should eq("playlist")
    config.links_path.should eq("spec/fixtures/links.txt")
  end

  it "loads links file" do
    config = MixcloudPlaylist::Config.load("spec/fixtures/config.yml")

    config.links.should eq(["http://mx.com", "http://mx1.com"])
  end
end

describe MixcloudPlaylist::Config, ".new" do
  it "loads config from parameters" do
    attrs = {
      sid: "sessionid1",
      csrftoken: "csrf1",
      playlist_name: "playlist1",
      links_path: "links1.txt",
    }

    config = MixcloudPlaylist::Config.new(attrs)
    config.sid.should eq("sessionid1")
    config.csrftoken.should eq("csrf1")
    config.playlist_name.should eq("playlist1")
    config.links_path.should eq("links1.txt")
  end

  it "loads links file" do
    config = MixcloudPlaylist::Config.load("spec/fixtures/config.yml")

    config.links.should eq(["http://mx.com", "http://mx1.com"])
  end
end
