require 'data_mapper'
require 'open-uri'
require 'json'

env = ENV['RACK_ENV'] || 'development'
db = ENV['DATABASE_URL'] || "postgres://@localhost/github_cv_#{env}"
DataMapper.setup(:default, db)

# github user data
class Github
  include DataMapper::Resource
  property :id,     Serial
  property :username,  String
  property :repos_url,  String
  property :cv_url,  String
  validates_presence_of :username, :repos_url, :cv_url

  def populate_attributes
    self.repos_url = "https://api.github.com/users/#{username}/repos"
    # repos = fetch_json repos_url
    # repo = repos.find { |r| r[:name] == 'CV' }
    self.cv_url = "https://api.github.com/repos/#{username}/#{'CV'}/readme"
  end

  def fetch_cv
    fetch_json cv_url
  end

  private

  def fetch_json(uri)
    raw_data = open(uri).read
    JSON.parse(raw_data, symbolize_names: true)
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!
