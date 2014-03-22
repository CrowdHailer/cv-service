require 'sinatra'
require 'awesome_print'
require './github'

# Sinatra router
class AppController < Sinatra::Base
  get '/' do
    'Hello World'
  end

  get '/:username.?:format?' do
    new_params = { username: params[:username] }
    github = Github.new(new_params)
    github.populate_attributes
    return github.cv_plain if params[:format] == 'plain'
    github.cv_html
  end
end
