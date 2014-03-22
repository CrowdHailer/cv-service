ENV['RACK_ENV'] = 'test'

require './app'
require 'rspec'
require 'rack/test'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

  before(:each) do
    stub_request(:any, 'https://api.github.com/users/CrowdHailer')
    .to_return(File.new('spec/fixtures/github_user_profile.txt'))
  end
