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
  @current_title = @contents[params['number'].to_i - 1]

  erb :chapter
end
