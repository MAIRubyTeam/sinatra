require File.expand_path '../test_helper.rb', __FILE__
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

class ApiTest < MiniTest::Unit::TestCase
  include Capybara::DSL
  include Rack::Test::Methods
  # Capybara.default_driver = :selenium # <-- use Selenium driver
  def setup
    Capybara.app = Sinatra::Application.new
  end

  def app
    Sinatra::Application
  end
=begin
  def response_body(last_response)
    get "/users"
    parsed_body = ActiveSupport::JSON.decode(last_response.body)
    p "PARSED_BODY"
    p parsed_body
    parsed_body
  end
=end
  def check_fields(id, name, i)
    get "/users"
    parsed_body = ActiveSupport::JSON.decode(last_response.body)
    p parsed_body
    p assert_equal parsed_body[i]["id"], id
    p assert_equal parsed_body[i]["name"], name
    p parsed_body[i]["id"]
    p parsed_body[i]["name"]
  end

  def home_page
    visit '/'
  end

  def test_entity_create
    post("/users", name: "vasya1")
    assert last_response.status == 200
    check_fields(1, "vasya1", 0)
    puts "________create"
  end
=begin
  def test_entity_delete
    delete 'users/1'

    assert last_response.status == 200
    check_fields(1, "vasya1", 0)
    puts "________delete"
  end


  def test_entity_update
    put '/users/1', name: "petya1"
    assert last_response.status == 200

    check_fields(1, "petya1", 0)
    puts "________update"
  end

  def test_get_entity_id
    test_get_entity

    get '/users/1'
    assert last_response.status == 200
    check_fields(1, "vasya1", 0)
    puts "________entity_id"
  end

  def test_get_entity
    get "/users"
    check_fields(1, "vasya1", 0)
    puts "________entity"
  end
=end
end