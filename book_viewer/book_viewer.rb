require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  @contents = File.readlines("data/toc.txt")

  erb :home
end

get "/chapters/:number" do
  @title = "Chapter #{params['number']}"
  @contents = File.readlines("data/toc.txt")
  @chapter = File.read("data/chp#{params['number']}.txt")

  erb :chapter
end

# get "/show/:name"  do
#   "Hello #{params['name']}!"
#   @name = params['name']
#
#   erb :name, layout: :name
# end
