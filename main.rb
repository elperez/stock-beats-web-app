require 'sinatra'
require 'rubygems'
require 'market_beat'
require 'simple_statistics'
require 'httparty'

get '/' do
  erb :index2
end

# http://localhost:4567/stock?stock=APPL
get '/stock' do
  # result = YahooFinance::get_quotes(YahooFinance::StandardQuote, params[:stock])
  # HTTParty.get('https://www.quandl.com/api/v3/datasets/WIKI/AAPL.json')
  request_link ='https://www.quandl.com/api/v3/datasets/WIKI/ #{params[:stock]}.json'
  result = HTTParty.get('https://www.quandl.com/api/v3/datasets/WIKI/AAPL.json')
  @data = result["dataset"]["data"]

  # beat_result = MarketBeat.quotes(:AAPL, "20011-12-21", "2011-12-22")

# zESs-hBzxtczjAM_Jcds
  # output in html
  erb :result
end

get '/login' do
  erb :login
end

get '/about' do
  'about me'
end


# /api/stock-prices?stock=goog
# /api/stock-prices?stock=goog&like=true
# /api/stock-prices?stock=goog&stock=msft
# /api/stock-prices?stock=goog&stock=msft&like=true
