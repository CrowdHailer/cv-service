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
  property :stats_uri,  String
  validates_presence_of :username, :stats_uri

  def populate_attributes
    self.stats_uri = "https://api.github.com/users/#{username}"
    fetch_json stats_uri
  end

  def fetch_json(uri)
    raw_data = open(uri).read
    JSON.parse(raw_data, symbolize_names: true)
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!
