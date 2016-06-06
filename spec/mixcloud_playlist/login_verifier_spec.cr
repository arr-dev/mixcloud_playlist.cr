require "../spec_helper"
require "../../src/mixcloud_playlist/config"
require "../../src/mixcloud_playlist/login_verifier"

describe MixcloudPlaylist::LoginVerifier do
  it "verifies login with correct sessionid" do
    WebMock.stub(:get, "#{MixcloudPlaylist::HOST}").
      with(headers: {"Cookie": "s=valid-sid"}).
      to_return(status: 200, body: %q{'start of body "_loggedIn": true' rest of body})

    login = MixcloudPlaylist::LoginVerifier.new("valid-sid")

    login.valid?.should be_true
  end

  it "fails login with wrong sessionid" do
    WebMock.stub(:get, "#{MixcloudPlaylist::HOST}").
      with(headers: {"Cookie": "s=wrong-sid"}).
      to_return(status: 200, body: %q{loggedout body})

    login = MixcloudPlaylist::LoginVerifier.new("wrong-sid")

    login.valid?.should be_false
  end

  it "succeeds with real requests" do
    if ENV.has_key?("REAL_SESSION_ID")
      WebMock.allow_net_connect = true

      login = MixcloudPlaylist::LoginVerifier.new(ENV["REAL_SESSION_ID"])

      login.valid?.should be_true
    end
  end
end
