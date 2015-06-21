class App < Sinatra::Base

	get '/app/:entity' do

		entity = params[:entity]

		column_editors = {'int' => 'numberfield', 'string' => 'textfield', 'date' => 'datefield'}

		columns = ActiveRecord::Base.connection.columns(entity)

		column_names = columns.map{|column| column.name }
		column_types = columns.map{|column| column.sql_type.gsub('varchar', 'string').gsub(/[^a-z]/) { '' }}

		column_array = [column_names, column_types]
		columns = Hash[*column_array.transpose.flatten]

		erb :app, :locals => {:entity => entity, :columns => columns, :column_editors => column_editors}
	end
end