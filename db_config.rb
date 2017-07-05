require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'stocktracker',
}

ActiveRecord::Base.establish_connection(options)
