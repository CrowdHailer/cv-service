require 'sinatra'
require 'awesome_print'
require './github'

env = ENV['RACK_ENV'] || 'development'

class AppController < Sinatra::Base
  get '/' do
    'Hello World'
  end

  get '/:username.?:format?' do
    new_params = { username: params[:username] }
    github = Github.new(new_params)
    github.populate_attributes
    github.stats_uri
  end
end
