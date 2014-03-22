ENV['RACK_ENV'] = 'test'

require './app'
require 'rspec'
require 'rack/test'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

stub_paths = {
  github_user_profile: 'https://api.github.com/users/CrowdHailer'
}
