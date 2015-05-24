require 'sinatra'
require 'sinatra/activerecord'
require 'active_record'
require 'rubygems'
require 'json'
require './config/environments.rb' 

get '/' do
  "Everybody can see this page"
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


