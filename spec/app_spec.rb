require 'spec_helper'

describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    AppController
  end

  before(:each) do
    stub_request(:any, 'https://api.github.com/users/CrowdHailer')
      .to_return(File.new('spec/fixtures/github_user_profile.txt'))
  end

  it 'says hello' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
  end

  it 'should return json data' do
    get '/CrowdHailer.json'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('https://api.github.com/users/CrowdHailer')
  end
end
