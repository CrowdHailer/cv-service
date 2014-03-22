ENV['RACK_ENV'] = 'test'

require './app'
require 'rspec'
require 'rack/test'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

STUB_PATHS = {
  user_details: 'https://api.github.com/users/CrowdHailer',
  user_repos: 'https://api.github.com/users/CrowdHailer/repos',
  user_cv_readme: 'https://api.github.com/repos/CrowdHailer/CV/readme'
}
