ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'active_support/testing/autorun'
require 'active_support/test_case'

require_relative './../app.rb'

def create_fixtures(*fixture_set_names, &block)
  FixtureSet.create_fixtures(ActiveSupport::TestCase.fixture_path, fixture_set_names, {}, &block)
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include ActiveRecord::TestFixtures
  self.fixture_path = "./test/fixtures/"
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # — they do not yet inherit this setting

  fixtures :all
  # Add more helper methods to be used by all tests here...

  include Rack::Test::Methods

  def App
    app
  end
end