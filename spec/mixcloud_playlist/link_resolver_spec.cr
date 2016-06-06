require "../spec_helper"
require "../../src/mixcloud_playlist/link_resolver"

describe MixcloudPlaylist::LinkResolver do
  it "resolves link to mixcloud url" do
    WebMock.stub(:get, "http://mx.com/shorturl").
      to_return(status: 302, headers: {"Location": "https://www.mixcloud.com/author/name"})
    WebMock.stub(:get, "https://www.mixcloud.com/author/name").
      to_return(status: 200)

    resolver = MixcloudPlaylist::LinkResolver.new("http://mx.com/shorturl")

    resolver.resolve.should eq("https://www.mixcloud.com/author/name")
  end

  it "resolves resursively to mixcloud url" do
    WebMock.stub(:get, "http://mx.com/short").
      to_return(status: 302, headers: {"Location": "https://mx.com/short"})
    WebMock.stub(:get, "http://mx.com/short").
      to_return(status: 302, headers: {"Location": "https://www.mixcloud.com/author/name"})
    WebMock.stub(:get, "https://www.mixcloud.com/author/name").
      to_return(status: 200)

    resolver = MixcloudPlaylist::LinkResolver.new("http://mx.com/shorturl")

    resolver.resolve.should eq("https://www.mixcloud.com/author/name")
  end
end
