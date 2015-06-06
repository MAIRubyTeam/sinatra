require 'sinatra'
require 'sinatra/activerecord'

get '/app' do
  table = Arel::Table.new("information_schema.TABLES")
  query = table.project(table[:TABLE_NAME]).where(table[:TABLE_SCHEMA].eq('database_development')).to_sql
  table_names = ActiveRecord::Base.connection.select_all(query).to_json


  table_names.gsub!('TABLE_NAME', '')
  table_names.tr!('{}[]:\"', '')
  table_names = table_names.split(',')

  column_query = []
  columns = Arel::Table.new("information_schema.COLUMNS")
    
  for i in 0...table_names.size
    column_query[i] = columns.project(columns[:COLUMN_NAME]).where(columns[:TABLE_NAME].eq(table_names[i])).to_sql
  end

  column_names = Array.new(table_names.size){|index| ActiveRecord::Base.connection.select_all(column_query[index]).to_json}

  for i in (0...table_names.size)
    column_names[i].gsub!('COLUMN_NAME', '')
    column_names[i].tr!('{}[]:\"', '')
    column_names[i] = column_names[i].split(',')
  end

  column_array = []
  for i in (0...table_names.size)
    column_array.push(table_names[i])
    column_array.push(column_names[i])
  end
    
  column_hash = Hash[*column_array]
  p column_hash

  erb :app, :locals => {:column_hash => column_hash.except('doctors_pacients', 'groups', 'groups_url_types', 'groups_users', 'meterings', 'pacients_doctors', 'schema_migrations', 'url_types', 'urls', 'users')}
end