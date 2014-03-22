require 'spec_helper'
require './github'

describe Github do
  let(:user) { Github.new(username: 'CrowdHailer') }
  let(:empty_user) { Github.new }

  before(:each) do
    stub_request(:any, STUB_PATHS[:github_user_profile])
      .to_return(File.new('spec/fixtures/github_user_profile.txt'))
  end

  it 'should be initialized with a username' do
    expect(user.username).to eq('CrowdHailer')
    expect(user).not_to be_valid
  end

  it 'should require a username' do
    expect(empty_user).not_to be_valid
    expect(empty_user.errors.on(:username)).not_to be_empty
  end

  it 'should require a users stats uri' do
    expect(empty_user).not_to be_valid
    expect(empty_user.errors.on(:stats_uri)).not_to be_empty
  end

  it 'should return a users api uri' do
    user.populate_attributes
    expect(user).to be_valid
    expect(user.stats_uri).to eq('https://api.github.com/users/CrowdHailer')
  end

  it 'should call github api for stats when populating data'do
    expect(user).to receive(:fetch_json)
      .with('https://api.github.com/users/CrowdHailer')
    user.populate_attributes
  end
end
