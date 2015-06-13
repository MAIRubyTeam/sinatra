require File.expand_path '../test_helper.rb', __FILE__

class ApiTest < ActiveSupport::TestCase

  include Capybara::DSL
  include Rack::Test::Methods

  def check_data(result, real_result)
    result[:columns].each_index do |i|
      assert_equal real_result.columns[i], result[:columns][i]
    end

    result[:rows].each_index do |i|
      result[:rows][i].each_index do |j|
        assert_equal real_result.rows[i][j], result[:rows][i][j]
      end
    end
  end

  def parse_response_json(response)
    data = ActiveSupport::JSON.decode(response)

    rows = []
    columns = [] 

    data.each do |row|
      temp_row = []
      row.each_pair do |col, val|
        columns << col unless columns.include? col
        temp_row << val
      end
      rows << temp_row
    end
    {columns: columns, rows: rows,  data: data }
  end

  def test_get_entity
    get '/users'
    assert last_response.ok?, last_response.inspect

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users")

    response_body = last_response.body
    result = parse_response_json(response_body)
    #p result
    #p real_result
    check_data(result, real_result)
  end

  def test_get_entity_id
    get "/users/'#{users(:user_two).id}'"
    assert last_response.ok?, last_response.inspect
    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE id = '#{users(:user_one).id}'")
    
    response_body = last_response.body
    result = parse_response_json(response_body)
    check_data(result, real_result)
  end

  def test_entity_create
    post "/users", name: "petya"
    assert last_response.ok?, last_response.inspect

    response_body = last_response.body
    result = parse_response_json(response_body)

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = petya")
    check_data(result, real_result)
  end

  def test_entity_delete
    delete 'users/265'
    assert last_response.ok?, last_response.inspect

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE id = 265")
    assert_empty real_result, real_result.inspect
  end

  def test_entity_update
    put '/users/1', name: "petya1"
    assert last_response.ok?, last_response.inspect

    response_body = last_response.body
    result = parse_response_to_json(response_body)
    
    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = petya1")
    assert_equal result, real_result
  end
end