# coding: utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rubygems'
require 'json'

get '/' do
  "Everybody can see this page"
end

delete '/:entity/:id' do
  
end

put '/:entity/:id' do

end

get '/:entity' do
  "Hello #{params['entity']}!"
end

get '/:entity/:id' do

end

post '/:entity' do

end
