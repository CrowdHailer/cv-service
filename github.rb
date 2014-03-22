require 'data_mapper'

DataMapper.setup(:default, "postgres://@localhost/github_cv_#{ENV['RACK_ENV']}")

class Github
  include DataMapper::Resource
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :username,  String
  property :stats_uri,  String
  validates_presence_of :username, :stats_uri

  def populate_attributes
    self.stats_uri = "https://api.github.com/users/#{username}"
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!