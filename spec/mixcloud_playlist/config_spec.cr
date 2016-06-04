require "../spec_helper"
require "../../src/mixcloud_playlist/config"

describe MixcloudPlaylist::Config, ".load" do
  it "loads config" do
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

