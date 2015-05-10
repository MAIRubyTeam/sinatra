ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'

require './../init.rb'