require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'rubygems'
require 'yahoofinance'
require 'simple_statistics'
require 'HTTParty'

require 'quandl'
Quandl::ApiConfig.api_key = 'zESs-hBzxtczjAM_Jcds'
Quandl::ApiConfig.api_version = '2015-04-09'
Quandl::Dataset.get('WIKI/AAPL')

get '/' do
  @languages = ['javascript', 'ruby', 'python']



  erb :index
end

# http://localhost:4567/stock?stock=APPL
get '/stock' do
  result = YahooFinance::get_quotes(YahooFinance::StandardQuote, params[:stock])
  quote = result[ params[:stock] ]



  @price = quote.lastTrade
  binding.pry
  stock_names = %w{MSFT RHT AAPL}
  start = Date.parse '2012-10-06'
  finish = Date.today
  closes = {}

  stock_names.each do |stock_name|
    quotes = YahooFinance::get_HistoricalQuotes(stock_name, start, finish)
    closes[stock_name] = quotes.collect { |quote| quote.close }
  end

  # output in html
  erb :result
end

get '/about' do
  'about me'
end
