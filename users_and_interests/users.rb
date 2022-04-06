require "yaml"

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def count_interests(list)
    user_count = list.count
    interests_count = 0

    list.each do |name, details|
      interests_count += details[:interests].count
    end

    "There are #{user_count} users with a total of #{interests_count} interests."
  end
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
