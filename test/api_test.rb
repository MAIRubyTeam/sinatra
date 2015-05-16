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
 	page.driver.delete("/users/id", name: "vasya")

 	assert page.status_code == 200
   	assert page.html == "{id: 2, name: 'vasya'}", page.html

  end

  def test_entity_changed
  	page.driver.put("/users/id", name: "dima")

  	assert page.status_code == 200
  	assert page.html == "{id: 3, name: 'dima'}", page.html
  end

  def test_get_entity_id
  	page.driver.get("/users/id", name: "ivan")

  	assert page.status_code == 200
  	assert page.html == "{id: 4, name: 'ivan'}", page.html
  end

  def test_get_entity
  	page.driver.get("/users", name: "ivan")

  	assert page.status_code == 200
  	assert page.html == "{id: 5, name: 'ivan'}", page.html
  end
end