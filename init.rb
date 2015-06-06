# encoding: utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'yaml'
require 'rack/csrf'
require "#{__dir__}/views/index_helper"
require "./extjs_generator"

current_env = ENV["RACK_ENV"] ? ENV["RACK_ENV"] : "development"
db_config = YAML::load_file("#{__dir__}/config/database.yml")
ActiveRecord::Base.configurations = db_config
ActiveRecord::Base.establish_connection(current_env.to_sym)

use Rack::Session::Cookie, :secret => "smth"
# use Rack::Csrf, :raise => true
enable :logging

def parse_body(req)
  body_data = req.body.read
  body_data.tr!("\"{}", "")
  body_data = body_data.split(",")
  body_data.map!{|elem| elem.split(":")}
  body_data = body_data[1..-1]
  body_data
end

get '/' do
  erb :index
end

post '/:entity' do
  body_data = parse_body(request)

  entity = Arel::Table.new(params[:entity])
  insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
  body_data.each{|field| field[0] = entity[field[0].to_sym]}
  insert_manager.insert(body_data)
  ActiveRecord::Base.connection.insert(insert_manager.to_sql).to_json
end


delete '/:entity/:id' do
  entity = Arel::Table.new(params[:entity])
  delete_manager = Arel::DeleteManager.new(ActiveRecord::Base)
  delete_manager.from(entity).where(entity[:id].eq(params[:id]))
  ActiveRecord::Base.connection.delete(delete_manager.to_sql).to_json
end

put '/:entity/:id' do
  body_data = parse_body(request)

  entity = Arel::Table.new(params[:entity])
  update_manager = Arel::UpdateManager.new(ActiveRecord::Base)
  body_data.each{|field| field[0] = entity[field[0].to_sym]}
  update_manager.table(entity).where(entity[:id].eq(params[:id]))
  update_manager.set(body_data)
  p update_manager.to_sql
  ActiveRecord::Base.connection.update(update_manager.to_sql).to_json
end

get '/:entity/:id' do
  entity = Arel::Table.new(params[:entity])
  select_manager = entity.project(Arel.star).where(entity[:id])
  ActiveRecord::Base.connection.select_one(select_manager.to_sql).to_json
end

get '/:entity' do
  entity = Arel::Table.new(params[:entity])
  select_manager = entity.project(Arel.star)
  ActiveRecord::Base.connection.select_all(select_manager.to_sql).to_json
end
