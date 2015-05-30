# encoding: utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'yaml'
require 'rack/csrf'
#require './views/index_helper'
require "#{__dir__}/views/index_helper"

current_env = ENV["RACK_ENV"] ? ENV["RACK_ENV"] : "development"
db_config = YAML::load_file("#{__dir__}/config/database.yml")
ActiveRecord::Base.configurations = db_config
ActiveRecord::Base.establish_connection(current_env.to_sym)
use Rack::Session::Cookie, :secret => "smth"
# use Rack::Csrf, :raise => true
enable :logging

get '/' do
  erb :index
end
#params
#insert
post '/:entity' do
  puts params.inspect
  entity = Arel::Table.new(params[:entity])
  insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
  insert_manager.insert([[entity[:name], params[:name]]])
  #hash.each {|key, value| ma "#{key} #{value}"} 
  ActiveRecord::Base.connection.insert(insert_manager.to_sql).to_json
end

#delete
delete '/:entity/:id' do
  entity = Arel::Table(:entity)
  query = entity.where(entity[:id])
  ActiveRecord::Base.connection.delete(query).to_json

=begin
  entity = Arel::Table(:entity)
  delete_manager = Arel::DeleteManager.new(entity, ActiveRecord::Base)
  delete_manager.from(entity).where(entity[:id])
  delete_manager.to_sql
end
=end
end

#update
put '/:entity/:id' do
  #{id: params[:id].to_i, name: params[:name]}.to_json
  entity = Arel::Table.new(:entity)
  #user = entity.find(:id)
  query = entity.where(entity[:id])
  ActiveRecord::Base.connection.update(query).to_json
end

#select
get '/:entity/:id' do
  #{id: params[:id].to_i, name: "ivan"}.to_json
  entity = Arel::Table.new(:entity)
  #name = entity.where(entity[:name])
  query = entity.project(Arel.sql("UPDATE #{:entity} SET name = #{:name_new}, WHERE name=#{:name}"))
  ActiveRecord::Base.connection.select_one(query).to_json
end

get '/:entity' do
  puts params.inspect
  entity = Arel::Table.new(:entity)
  query = entity.project(Arel.star)
  ActiveRecord::Base.connection.select_all(query).to_json
  #[{id: 1, name: "kolya"},{id: 2, name: "petya"}].to_json
end

