require "yaml"

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

before do
  @users = YAML.load_file("users.yaml")
end

get '/' do
  redirect '/users'
end

get '/users' do

  erb :users
end

get '/users/:name' do
  @name = params[:name]
  @hobby = @users[@name.to_sym]

  erb :current_user
end
