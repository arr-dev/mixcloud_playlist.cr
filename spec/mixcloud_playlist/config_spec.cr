require "../spec_helper"
require "../../src/mixcloud_playlist/config"

describe MixcloudPlaylist::Config, ".load" do
  it "loads config from yml" do
    config = MixcloudPlaylist::Config.load("spec/fixtures/config.yml")
    config.access_token.should eq("TOKEN")
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
      access_token: "token1",
      links_path: "links1.txt",
    }

    config = MixcloudPlaylist::Config.new(attrs)
    config.access_token.should eq("token1")
    config.links_path.should eq("links1.txt")
  end
end
