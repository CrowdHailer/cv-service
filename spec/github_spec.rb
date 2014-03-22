require 'spec_helper'
require './github'

describe Github do
  let(:user) { Github.new(username: 'CrowdHailer') }
  let(:empty_user) { Github.new }

  before(:each) do
    stub_request(:any, STUB_PATHS[:github_user_profile])
      .to_return(File.new('spec/fixtures/github_user_profile.txt'))
  end

  [:username, :repos_url, :cv_url].each do |attribute|
    it "it should require a #{attribute}" do
      expect(empty_user).not_to be_valid
      expect(empty_user.errors.on(attribute)).not_to be_empty
    end
  end

end
