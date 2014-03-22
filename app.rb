require 'sinatra'

env = ENV['RACK_ENV'] || "development"

class AppController < Sinatra::Base
  get '/' do
    'Hello World'
  end
end