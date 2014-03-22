require 'sinatra'
require 'awesome_print'

env = ENV['RACK_ENV'] || "development"

class AppController < Sinatra::Base
  get '/' do
    'Hello World'
  end
end