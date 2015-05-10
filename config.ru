path = File.expand_path "../", __FILE__

require 'rubygems'
require 'sinatra'
require "#{path}/init"

run Sinatra::Application
