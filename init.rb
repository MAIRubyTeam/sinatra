# coding: utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rubygems'
require 'json'

get '/' do
  "Everybody can see this page"
end

post '/:entity' do
  "{id: 1, name: '#{params[:name]}'}"
end
delete '/:entity/:id' do
  "{id: 2, name: '#{params[:name]}'}"
end

put '/:entity/:id' do
  "{id: 3, name: '#{params[:name]}'}"
end

get '/:entity/:id' do
  "{id: 4, name: '#{params[:name]}'}"
end

get '/:entity' do
  "{id: 5, name: '#{params[:name]}'}"
end


