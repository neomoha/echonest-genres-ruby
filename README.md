Get artist genre(s) from The Echo Nest API
======

A small script in Ruby to get the artist genre (or a list of genres) from the Echo Nest API, if the artist exists

Dependencies
------

* [echowrap](https://github.com/timcase/echowrap)
* [httparty](https://github.com/jnunemaker/httparty)
* [json](https://rubygems.org/gems/json)

How to use this code
------

Edit the script [echonest_genre.rb](https://github.com/neomoha/echonest-genres-ruby/blob/master/echonest_genre.rb) and change the line:

API_KEY = 'YOUR_ECHONEST_API_KEY_HERE'

with your own Echo Nest API key. For more information about how to get the API key, please refer to Echo Nest [API Documentation](https://developer.echonest.com/account/register)

Examples
------

$ ruby echonest_genre.rb -h
Usage: echonest_genre.rb [options]
    -n, --name NAME                  Artist name
    -m, --genre_method METHOD        Get "single" genre or a "list" genres (default="single")
    
$ ruby echonest_genre.rb -n Diversidad

Artist 'Diversidad' has genre 'european' in echonest


$ ruby echonest_genre.rb -n Diversidad -m list

Artist Diversidad does not have genre information in echonest


$ ruby echonest_genre.rb -n Luche -m list

Artist Luche does not have genre information in echonest


$ ruby echonest_genre.rb -n Luche -m single

Artist 'Luche' has genre 'italian rap' in echonest


$ ruby echonest_genre.rb -n Weezer -m single

Artist 'Weezer' has genre 'rock' in echonest


$ ruby echonest_genre.rb -n Weezer -m list

Artist Weezer has genres ["permanent wave", "alternative rock", "punk christmas", "power pop", "indie christmas", "pop rock", "pop christmas", "rock"] in echonest


$ ruby echonest_genre.rb -n Weezer

Artist 'Weezer' has genre 'rock' in echonest
