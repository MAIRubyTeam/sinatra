# coding: utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rubygems'
require 'json'
require "rack/csrf"
require './views/index_helper'

use Rack::Session::Cookie, :secret => "smth"
use Rack::Csrf, :raise => true

get '/' do
  erb :index
end
post '/:entity' do
  {id: 1, name: params[:name]}.to_json
end

delete '/:entity/:id' do
end

put '/:entity/:id' do
  {id: params[:id].to_i, name: params[:name]}.to_json
end

get '/:entity/:id' do
  {id: params[:id].to_i, name: "ivan"}.to_json
end

get '/:entity' do
  [{id: 1, name: "kolya"},{id: 2, name: "petya"}].to_json
end

