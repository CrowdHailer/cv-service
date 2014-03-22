require 'spec_helper'
require './github'

describe Github do

  before(:each) do
    stub_request(:any, STUB_PATHS[:github_user_profile])
      .to_return(File.new('spec/fixtures/github_user_profile.txt'))
  end

  context 'Unpopulated github user' do
    let(:user) { Github.new }
    [:username, :repos_url, :cv_url].each do |attribute|
      it "it should require a #{attribute}" do
        expect(user).not_to be_valid
        expect(user.errors.on(attribute)).not_to be_empty
      end
    end
  end

  context 'User github routes defined from username' do
    let(:user) { Github.new(username: 'CrowdHailer') }
    it 'should be created invalid' do
      expect(user).not_to be_valid
    end

  end

end
