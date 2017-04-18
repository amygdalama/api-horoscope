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

post '/tweet' do
  prediction = params['prediction']
  wiki_url = params['wiki_url']
  puts "wiki url!!!" + wiki_url
  status = "#{prediction} #{wiki_url}"
  consumer = OAuth::Consumer.new(
    ENV['API_KEY'],
    ENV['API_SECRET'],
    { site: 'https://api.twitter.com', scheme: 'header' }
  )
  token_hash = { oauth_token: ENV['ACCESS_TOKEN'], oauth_token_secret: ENV['ACCESS_TOKEN_SECRET'] }
  access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  response = access_token.request(:post, 'https://api.twitter.com/1.1/statuses/update.json', status: status)
  puts response
  redirect to('/')
end
