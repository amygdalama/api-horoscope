require 'dotenv'
Dotenv.load
require 'httparty'
require 'oauth'
require 'sinatra'

get '/' do
  url = 'https://en.wikipedia.org/w/api.php?action=query&list=random&rnnamespace=0&format=json'
  response = HTTParty.get(url)
  title = response['query']['random'][0]['title']
  page_id = response['query']['random'][0]['id']
  @wiki_url = "https://en.wikipedia.org/?curid=#{page_id}"
  @prediction = "You will have a day full of #{title}!"
  erb :index
end
