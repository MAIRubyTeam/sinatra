require 'sinatra'
require 'sinatra/activerecord'

get '/app/:entity' do

  entity = params[:entity]

  columns = ActiveRecord::Base.connection.columns(entity)

  column_names = columns.map{|column| column.name }

  erb :app, :locals => {:entity => entity, :columns => column_names}
end