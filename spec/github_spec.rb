require 'spec_helper'
require './github'

describe Github do

  before(:each) do
    STUB_PATHS.each do |k, path|
      stub_request(:any, path)
        .to_return(File.new("spec/fixtures/#{k}.txt"))
    end
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

    it 'should generate repos_url' do
      user.populate_attributes
      expect(user.cv_url).to eq(STUB_PATHS[:user_cv_readme])
    end

    it 'should call for cv' do
      user.populate_attributes
      # ap user.cv_plain
      ap user.cv_html
    end

  end

end
