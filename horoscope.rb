require 'dotenv'
Dotenv.load
require 'httparty'
require 'oauth'
require 'sinatra'

get '/' do
  url = 'https://en.wikipedia.org/w/api.php?action=query&list=random&rnnamespace=0&format=json'
  response = HTTParty.get(url)
  title = response['query']['random'][0]['title']
  @prediction = title
  erb :index
end
