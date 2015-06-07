require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'json'
require 'yaml'
require 'rack/csrf'
require "#{__dir__}/../controllers/extjs_generator.rb"
require "#{__dir__}/../controllers/api.rb"
require "#{__dir__}/../views/index_helper.rb"

current_env = ENV["RACK_ENV"] ? ENV["RACK_ENV"] : "development"
db_config = YAML::load_file("#{__dir__}/database.yml")
ActiveRecord::Base.configurations = db_config
ActiveRecord::Base.establish_connection(current_env.to_sym)

use Rack::Session::Cookie, :secret => "smth"
#use Rack::Csrf, :raise => true
enable :logging

