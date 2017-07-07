# require 'pry'
require 'sinatra'
# require 'sinatra/reloader'
require 'rubygems'
require 'market_beat'
require 'simple_statistics'
require 'httparty'

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/stock'

enable :sessions

get '/' do
  erb :index2
end

get '/stock' do
  # result = HTTParty.get('https://www.quandl.com/api/v3/datasets/WIKI/aapl.json')
  @user = User.where(id: session[:user_id])
  @result = []
  request_link ="https://www.quandl.com/api/v3/datasets/WIKI/" + params[:stock] + ".json"
  dataset = HTTParty.get(request_link)

  if dataset
    # binding.pry
    draft = {:stockName => params[:stock].upcase,
      :data =>dataset["dataset"]["data"]
    }
    @result.push(draft)
    @user.stock_favorites.push(params[:stock].upcase)
    @user.save
  end

  @user.stock_favorites.each do |stock|
    # binding.pry
    if (stock != params[:stock].upcase)
      request_link ="https://www.quandl.com/api/v3/datasets/WIKI/" + stock.upcase + ".json"
      dataset = HTTParty.get(request_link)
      if dataset != nil || dataset != null
        draft = {:stockName => params[:stock].upcase,
          :data =>result["dataset"]["data"]
        }
        @result.push(draft)
      end
    end
  end

  # beat_result = MarketBeat.quotes(:AAPL, "20011-12-21", "2011-12-22")
  # zESs-hBzxtczjAM_Jcds
  erb :show
end

get '/login' do
  erb :login
end

get '/about' do
  'about me'
end

# handle login button
post '/session' do
  # search for the user in the db
  user = User.find_by(email: params[:email])
  # authenticate that user with the password they gave you

  if user && user.authenticate(params[:password])
    # create a session
    session[:user_id] = user.id
    # redirect to protected page
    redirect "/user/#{session[:user_id]}"
    # redirect "/user/" + user.id
  else
    @error = "invalid email or password"
    erb :index2
  end
end

#post add stock
# post '/' do
#      stock.create(stock code, user id)
# end

# show sign up form
get '/user/signup' do
  erb :signup
end
# handle when logging in
get '/user/:id' do
  @user = User.find(params[:id])

  @result = []

  @user.stock_favorites.each do |stock|
    request_link ="https://www.quandl.com/api/v3/datasets/WIKI/" + stock.upcase + ".json"
    dataset = HTTParty.get(request_link)
    if dataset
      # binding.pry
      draft = {:stockName => stock.upcase,
        :data =>dataset["dataset"]["data"]
      }
      @result.push(draft)
      # @result = dataset["dataset"]["data"]
    end
  end
  erb :show, layout: false
end



# handle sign up finalize
post '/user/new' do

  if user && user.authenticate(params[:password])
    # binding.pry
    # create a session
    session[:user_id] = user.id
  end
  redirect "/user/#{session[:user_id]}"
end


# # handle logout (is this for logout or delete user)
# delete '/session' do
#   session[:user_id] = nil
#   redirect '/login'
# end



# /api/stock-prices?stock=goog
# /api/stock-prices?stock=goog&like=true
# /api/stock-prices?stock=goog&stock=msft
# /api/stock-prices?stock=goog&stock=msft&like=true
