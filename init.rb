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
  ActiveRecord::Base.connection.insert(insert_manager.to_sql).to_json
end

#delete
delete '/:entity/:id' do
  entity = Arel::Table.new(params[:entity])
  delete_manager = Arel::DeleteManager.new(ActiveRecord::Base)
  delete_manager.from(entity).where(entity[:id])
  ActiveRecord::Base.connection.delete(delete_manager.to_sql).to_json
end

#update
put '/:entity/:id' do
  #{id: params[:id].to_i, name: params[:name]}.to_json
  entity = Arel::Table.new(params[:entity])
  update_manager = Arel::UpdateManager.new(ActiveRecord::Base)
  update_manager.table(entity).where(entity[:id])
  update_manager.set([[entity[:name], params[:name]]])
  ActiveRecord::Base.connection.update(update_manager.to_sql).to_json
end

#select
get '/:entity/:id' do
  #{id: params[:id].to_i, name: "ivan"}.to_json
  entity = Arel::Table.new(params[:entity])
  select_manager = entity.project(Arel.star).where(entitys[:id])
  ActiveRecord::Base.connection.select_one(select_manager.to_sql).to_json
end

get '/:entity' do
  puts params.inspect
  entity = Arel::Table.new(params[:entity])
  select_manager = entity.project(Arel.star)
  ActiveRecord::Base.connection.select_all(select_manager.to_sql).to_json
  #[{id: 1, name: "kolya"},{id: 2, name: "petya"}].to_json
end

