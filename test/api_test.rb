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
    get "/users/'#{users(:user_one).id}'"
    assert last_response.ok?, last_response.inspect

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE id = '#{users(:user_one).id}'")

    response_body = last_response.body
    result = parse_response_json(response_body)
    check_data(result, real_result)
  end

  def test_entity_create
    post "/users/", "#{users(:user_one).name}"
    #assert last_response.ok?, last_response.inspect
    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = '#{users(:user_one).name}'")

    request_body = last_request.body.string
    result = parse_response_json(request_body)
    check_data(result, real_result)
  end

  def test_entity_delete
    delete "users/", "#{users(:user_one).name}"

    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = '#{users(:user_five).name}'")
    p real_result
    assert_empty real_result, real_result.inspect
  end

  def test_entity_update
    put "/users/", "#{users(:user_one).name}"
    #assert last_response.ok?, last_response.inspect

    request_body = last_request.body.string
    result = parse_response_json(request_body)
    
    real_result = ActiveRecord::Base.connection.select_all("
    SELECT * FROM users WHERE name = '#{users(:three).name}'")
    assert_equal result, real_result
  end
end