require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'stockbeats_db',
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']|| options)
