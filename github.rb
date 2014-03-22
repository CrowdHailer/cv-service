require 'data_mapper'

DataMapper.setup(:default, "postgres://@localhost/github_cv_#{ENV['RACK_ENV']}")

class Github
  include DataMapper::Resource
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :username,  String
  # def initialize username
  #   @username = username
  # end

  # attr_reader :username

  # def stats_uri
  #   "https://api.github.com/users/#{username}"
  # end

end

DataMapper.finalize
DataMapper.auto_upgrade!