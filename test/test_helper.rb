ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'active_support/testing/autorun'
require 'active_support/test_case'

require_relative './../init.rb'