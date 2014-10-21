#!/usr/bin/env ruby

require 'echowrap'
require 'optparse'
require 'httparty'
require 'json'

API_KEY = 'YOUR_ECHONEST_API_KEY_HERE'

Echowrap.configure do |config|
  config.api_key = API_KEY
end

def find_artist(artist_name)
  Echowrap.artist_search(:name => artist_name, :results => 1, :bucket => ['genre'])
end

def get_genres(artist)
  genres = Array.new()
  for genre in artist.attrs[:genres]
    genres.push(genre[:name])
  end
  return genres
end

def get_genre(artist)
  genre = nil
  url = "http://developer.echonest.com/api/v4/artist/genres?api_key="+API_KEY+"&id="+artist.id
  response = HTTParty.get(url)
  parsed_response = JSON.parse(response.body)
  if parsed_response["response"]["status"]["code"] == 0
    if parsed_response["response"]["terms"]["genre"].empty? == false
      genre = parsed_response["response"]["terms"]["genre"]
    end
  end
end

if __FILE__ == $0
  options = OpenStruct.new
  options.genre_method="single"
  OptionParser.new do |opts|
    opts.banner = "Usage: echonest_genre.rb [options]"
    opts.on('-n', '--name NAME', 'Artist name') { |v| options.name = v }
    opts.on('-m', '--genre_method METHOD', 'Get "single" genre or a "list" genres (default="single")')\
      { |v| options.genre_method = v }
  end.parse!
  
  if options.name == nil
    abort("ERROR: You should specify an artist name")
  end
  
  result = find_artist(options.name)
  if result.count > 0
    if options.genre_method == "list"
      genres = get_genres(result[0])
      if genres.count > 0
        puts "Artist '#{result[0].name}' has genres #{genres} in echonest"
      else
        puts "Artist '#{result[0].name}' does not have genre information in echonest"
      end
    else # single
      genre = get_genre(result[0])
      if genre.empty? == false
        puts "Artist '#{result[0].name}' has genre '#{genre}' in echonest"
      else
        puts "Artist '#{result[0].name}' does not have genre information in echonest"
      end
    end
  else
    puts "Artist '#{options.name}' does not exist in echonest"
  end
end