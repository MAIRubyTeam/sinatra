class App < Sinatra::Base
  private
    def parse_body(req)
     body_data = req.body.read
     body_data.tr!("\"{}", "")
     body_data = body_data.split(",")
     body_data.map!{|elem| elem.split(":")}
     body_data = body_data[1..-1]
     body_data
    end

    def output_data(data)
        request.accept.each do |type|
          type_str = type.to_s
          p type_str  
          return (data ? data.to_json : nil), type_str
        end
    end

    def get_records_by_data_insertion(entity, data_insertion)
      primary_key = entity.primary_key.name
      select_manager = entity.project(Arel.star)
      select_manager = select_manager.where(entity[primary_key].in(data_insertion))
      ActiveRecord::Base.connection.select_all(select_manager.to_sql)
    end
    
    def get_content_for_data_insertion(entity, data_insertion)
      temp_data = get_records_by_data_insertion(entity, data_insertion)
      data, type_str = output_data(temp_data)
    end

  public
    post '/:entity' do
      body_data = parse_body(request)

      entity = Arel::Table.new(params[:entity])
      primary_key = entity.primary_key

      if primary_key
        data_insertion_1 = []

        insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
        body_data.each {|field| field[0] = entity[field[0].to_sym]}
        data_insertion_1 << insert_manager.insert(body_data)

        get_content_for_data_insertion(entity, data_insertion_1)
      else
        data_insertion_2 = []

        insert_manager = Arel::UpdateManager.new(ActiveRecord::Base)
        body_data.each {|field| field[0] = entity[field[0].to_sym]}
        insert_manager.table(entity).where(entity[:id].eq(params[:id]))
        insert_manager.set(body_data)
        data_insertion_2 << insert_manager.to_sql

        ActiveRecord::Base.connection.insert(data_insertion_2.join(';\n'))
      end
    end

    delete '/:entity/:id' do
      entity = Arel::Table.new(params[:entity])
      delete_manager = Arel::DeleteManager.new(ActiveRecord::Base)
      delete_manager.from(entity).where(entity[:id].eq(params[:id]))
      
      ActiveRecord::Base.connection.delete(delete_manager.to_sql).to_json
    end

    put '/:entity/:id' do
      body_data = parse_body(request)

      data_insertion = nil
      primary_key = entity.primary_key.name

      entity = Arel::Table.new(params[:entity])
      p params[:id]
      if params[:id]
        data_insertion = [params[:id]] 
      else
        select_manager = entity.where(entity[:id])
        select_manager = select_manager.project(entity[primary_key])
        key = ActiveRecord::Base.connection.select_all(select_manager.to_sql)
        data_insertion = key.rows.map{ |elem| p elem.first }
      end
      
      update_manager = Arel::UpdateManager.new(ActiveRecord::Base)
      body_data.each{|field| field[0] = entity[field[0].to_sym]}
      update_manager.table(entity).where(entity[:id].eq(params[:id]))
      update_manager.set(body_data)
      ActiveRecord::Base.connection.update(update_manager.to_sql).to_json

      if !data_insertion.empty? && data_insertion
        get_content_for_data_insertion(entity, data_insertion)
      else
        content_type request.accept.first
      end
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

    not_found do
      erb :error, :locals => {:message => env['sinatra.error'].message}
    end
  end