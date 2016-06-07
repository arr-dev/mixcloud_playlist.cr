require "../spec_helper"
require "../../src/mixcloud_playlist/link_resolver"

describe MixcloudPlaylist::LinkResolver do
  it "resolves link to mixcloud url" do
    WebMock.stub(:head, "https://mx.com/shorturl").
      to_return(status: 302, headers: {"Location": "/author/name"})
    WebMock.stub(:head, "https://mx.com/author/name").
      to_return(status: 200)

    resolver = MixcloudPlaylist::LinkResolver.new("https://mx.com/shorturl")

    resolver.resolve.should eq("https://mx.com/author/name")
  end

  it "resolves resursively to mixcloud url" do
    WebMock.stub(:head, "http://mx.com/short").
      to_return(status: 302, headers: {"Location": "https://smx.com/short"})
    WebMock.stub(:head, "https://smx.com/short").
      to_return(status: 302, headers: {"Location": "/author/name"})
    WebMock.stub(:head, "https://smx.com/author/name").
      to_return(status: 200)

    resolver = MixcloudPlaylist::LinkResolver.new("http://mx.com/short")

    resolver.resolve.should eq("https://smx.com/author/name")
  end
end
