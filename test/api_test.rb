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
    assert_page_has_content?('Everybody can see this page')
  end


  
end