require 'data_mapper'
require 'open-uri'
require 'json'

DataMapper.setup(:default, "postgres://@localhost/github_cv_#{ENV['RACK_ENV']}")

class Github
  include DataMapper::Resource
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :username,  String
  property :stats_uri,  String
  validates_presence_of :username, :stats_uri

  def populate_attributes
    self.stats_uri = "https://api.github.com/users/#{username}"
    fetch_json stats_uri
  end

  def fetch_json uri
    raw_data = open(uri).read
    out = JSON.parse(raw_data, :symbolize_names => true)
    ap out
    out
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!