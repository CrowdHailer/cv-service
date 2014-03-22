require 'sinatra'

class AppController < Sinatra::Base
  get '/' do
    'Hello World'
  end
end