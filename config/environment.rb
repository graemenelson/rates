rates_env = ENV['RATES_ENV'] || "development"

require 'rubygems'
require 'yaml'
require 'bundler/setup'
Bundler.require(:default, rates_env.to_sym)
require 'dotenv'

Dotenv.load(".env.#{rates_env}", ".env")

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
Que.connection = ActiveRecord
