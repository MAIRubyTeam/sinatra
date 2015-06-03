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

def delete_bad_params(parameters)
  parameters.delete("entity")
  parameters.delete("captures")
  parameters.delete("splat")
end

get '/' do
  erb :index
end

get '/app' do
  erb :app
end
#params
#insert
post '/:entity' do
  entity = Arel::Table.new(params[:entity])

  insert_manager = Arel::InsertManager.new(ActiveRecord::Base)

  parameters = params
  delete_bad_params(parameters)
  
  par = parameters.to_a
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

  for i in 0...parameters.size
    tmp = par[i][0]
    tmp.to_sym
    par[i][0] = entity[tmp]
  end

  puts "----------------------------------"
  #puts parameters
  insert_manager.insert(par)
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

  parameters = params
  delete_bad_params(parameters)

  par = parameters.to_a
  puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4"

  for i in 0...parameters.size
    puts "***************************"
    #p par[i][0]
    tmp = par[i][0]
    tmp.to_sym
    par[i][0] = entity[tmp]
    #p entity[par[i][0]]
  end

  puts "----------------------------------"
  update_manager.set(par)
  ActiveRecord::Base.connection.update(update_manager.to_sql).to_json
end

#select
get '/:entity/:id' do
  #{id: params[:id].to_i, name: "ivan"}.to_json
  puts params.inspect
  puts "?????????????"
  entity = Arel::Table.new(params[:entity])
  select_manager = entity.project(Arel.star).where(entity[:id])
  ActiveRecord::Base.connection.select_one(select_manager.to_sql).to_json
end

get '/:entity' do
 
  entity = Arel::Table.new(params[:entity])
  puts
  
  select_manager = entity.project(Arel.star)
  puts select_manager

  p params[:entity]

  puts "-----------"

  #entity.columns
  #puts "-----------"

  ActiveRecord::Base.connection.select_all(select_manager.to_sql).to_json
  #[{id: 1, name: "kolya"},{id: 2, name: "petya"}].to_json
end

