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

  def home_page
    visit '/'
    assert page.has_content?('Everybody can see this page')
  end

  def test_entity_save
  	page.driver.post("/users", name: "petya")

  	assert page.status_code == 200
   	assert page.html == "{id: 1, name: 'petya'}", page.html
 end

 def test_entity_delete
 	page.driver.submit :delete, "/users/id", {}

 	assert page.status_code == 200
   	assert has_content?

  end

  def test_entity_changed
  	test_get_entity_id

  	put '/users/4', name: "kolya"
  	assert last_response.status == 200

  	parsed_body = ActiveSupport::JSON.decode(last_response.body)
  	assert_equal parsed_body["id"], 4, parsed_body
  	assert_equal parsed_body["name"], "kolya", parsed_body
  end

  def test_get_entity_id
  	get '/users/4'
  	assert last_response.status == 200
  	
  	parsed_body = ActiveSupport::JSON.decode(last_response.body)
  	assert_equal parsed_body["id"], 4, parsed_body
  	assert_equal parsed_body["name"], "ivan", parsed_body
  	
  end

  def test_get_entity
  	get '/users'
  	assert last_response.status == 200

    parsed_body = ActiveSupport::JSON.decode(last_response.body)
    assert_instance_of(Array, parsed_body)
    assert_equal parsed_body.length, 2
  end
end