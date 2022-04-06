require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

helpers do
  def in_paragraphs(str)
    str.split("\n\n").map { |para| "<p>#{para}<\p>" }.join
  end

  def each_chapter
    @contents.each_with_index do |name, index|
      number = index + 1
      contents = File.read("data/chp#{number}.txt")
      yield number, name, contents
    end
  end

  def chapters_matching(query)
    results = []

    return results if !query || query.empty?

    each_chapter do |number, name, contents|
      results << {number: number, name: name} if contents.include?(query)
    end

    results
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
  @results = chapters_matching(params[:query])
  erb :search
end
