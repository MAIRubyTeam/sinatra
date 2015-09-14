class App < Sinatra::Base
  # отображение типов данных на типы редактора ячеек
  COLUMN_EDITORS = {
    int: 'numberfield',
    string: 'textfield',
    date: 'datefield'
  }
  
  # для создания javascript-приложения необходим ассоциативный массив
  # с ключами наименованиями колонок и значениями типами данных
  get '/app/:entity' do
	entity = params[:entity]

	columns = ActiveRecord::Base.connection.columns(entity)
	js_columns = {}
	
	columns.each do |column|
	  js_columns[column.name] = column.sql_type.gsub('varchar', 'string').gsub(/[^a-z]/) { '' }
	end

	erb :app, locals: {entity: entity, columns: js_columns, column_editors: COLUMN_EDITORS}
  end
end
