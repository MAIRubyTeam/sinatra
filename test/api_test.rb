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

  	assert page.status_code == 201
   	assert page.html == "{id: 1, name: 'petya'}", page.html
 end

 def test_entity_delete
 	page.driver.submit :delete, "/users/id", {}

 	assert page.status_code == 200
   	assert has_content?

  end

  def test_entity_changed
  	page.driver.put("/users/id", name: "dima")

  	assert page.status_code == 200
  	assert page.html == "{id: 3, name: 'dima'}", page.html
  end

  def test_get_entity_id
  	@expected = { name: "ivan" }.to_json
  	page.driver.get("/users/id", name: "ivan")

  	response.body.should == @expected
  	parsed_body = JSON.parse(response.body)

  	assert parced_body.exist?
  	assert parced_body.where(id: 4 ,name: "ivan")

  	#user = ActiveSupport::JSON.decode(last_response.body)

  	#assert last_response.ok?
    #assert_match('application/json', last_response.content_type)

  	assert page.status_code == 200
  	assert page.html == "{id: 4, name: 'ivan'}", page.html
  end

  def test_get_entity
  	page.driver.get("/users", name: "ivan")
    #user = ActiveSupport::JSON.decode(last_response.body)

    #assert last_response.ok?
    #assert_equal(false, last_response.successful?)
    #assert_match('application/json', last_response.content_type)
  end
end