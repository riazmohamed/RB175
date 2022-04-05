require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

helpers do
  def in_paragraphs(str)
    str.split("\n\n").map { |para| "<p>#{para}<\p>" }.join
  end

  def split_into_words(str, word)
    str.split(/[ .]/).map(&:downcase).any? { |string| string.match(/#{word}/)}
  end
end

not_found do
  redirect '/'
end

before do
  @contents = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @contents[number - 1]

  redirect '/' unless (1..@contents.size).cover? number

  @title = "Chapter #{number}: #{chapter_name}"
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end

get "/search" do
  @value = params['query']

  @arr = (@contents.select.with_index do |chapter, idx|
    @chapter = File.read("data/chp#{idx + 1}.txt")
    split_into_words(@chapter, @value)
  end)

  erb :search
end
