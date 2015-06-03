require File.expand_path '../test_helper.rb', __FILE__

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

  def check_fields(id, name)
    parsed_body = ActiveSupport::JSON.decode(last_response.body)
    assert_equal parsed_body["id"], id, parsed_body
    assert_equal parsed_body["name"], name, parsed_body
  end

  def home_page
    visit '/'
    assert page.has_content?('Everybody can see this page')
  end

  def test_entity_create
    post("/users", name: "petya")

    assert last_response.status == 200
    check_fields(5, "petya")
  end

  def test_entity_delete
    delete 'users/1'

    assert last_response.status == 200
  end

  def test_entity_update
    test_get_entity_id

    put '/users/1', name: "petya"
    assert last_response.status == 200

    check_fields(1, "petya")
  end

  def test_get_entity_id
    get '/users/1'
    assert last_response.status == 200

    check_fields(1, "petya")
  end

  def test_get_entity
    get '/users'
    assert last_response.status == 200

    parsed_body = ActiveSupport::JSON.decode(last_response.body)
    assert_instance_of(Array, parsed_body)
    assert_equal parsed_body.length, 1
  end

end