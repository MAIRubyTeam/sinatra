require File.expand_path '../test_helper.rb', __FILE__

class ApiTest < ActiveSupport::TestCase

  include Capybara::DSL
  include Rack::Test::Methods

  def test_get_entity
    get '/users'
    assert last_response.ok?, last_response.inspect

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users")

    response_body = last_response.body
    result = parse_response_json(response_body)
    check_data(result, real_result)
  end

  def test_get_entity_id
    get "/users/#{users(:user_one).id}"
    assert last_response.ok?, last_response.inspect

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE id = '#{users(:user_one).id}'")

    response_body = last_response.body
    result = parse_response_json(response_body)
    check_data(result, real_result)
  end

  def test_entity_create
      data = {
        name: 'user10'
      }
    
    post '/users', data.to_json, "CONTENT_TYPE" => "application/json"
    assert last_response.ok?
    result = parse_response_json(data.to_json)

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE id = '#{result[:id]}'")
    p real_result
    check_data(result, real_result)
  end

  def test_entity_delete
    delete "/users"

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = '#{users(:user_five).name}'")

    assert_empty real_result, real_result.inspect
  end

  def test_entity_update
    data_obj = {
      data: [
        {name: 'user10'}
      ]
    }
    post "/users", data_obj.to_json, "CONTENT_TYPE" => "application/json"
    assert last_response.ok?
    assert_not_nil last_response

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = '#{data_obj[:data].first[:name]}'")

    result = parse_response_json(data_obj.to_json)
    check_data(result, real_result)
  end
end