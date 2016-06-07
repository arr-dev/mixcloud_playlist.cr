require "spec"
require "../src/mixcloud_playlist"

require "webmock"
Spec.before_each &->WebMock.reset
