ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'arel'
require 'active_support/testing/autorun'
require 'active_support/test_case'
require 'database_cleaner'

require_relative './../app.rb'

def create_fixtures(*fixture_set_names, &block)
  FixtureSet.create_fixtures(ActiveSupport::TestCase.fixture_path, fixture_set_names, {}, &block)
  #FixtureSet.each(&block)
end

class ActiveSupport::TestCase

  ActiveRecord::Migration.check_pending!
  include ActiveRecord::TestFixtures
  self.fixture_path = "./test/fixtures/"

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # — they do not yet inherit this setting

  self.use_transactional_fixtures = true

  fixtures_names = []
  Dir.glob("#{__dir__}/fixtures/*.yml").each do |file_name| 
    fixtures_names.push(file_name.split("/")[-1].split(".")[0])
  end

  fixtures_names.each do |file_name|
    if (file_name.include? "_")
      index = file_name.index("_")
      file_name.tr!("_", "")
      file_name.capitalize!
      file_name.gsub!(file_name[index], file_name[index].capitalize)
    else
      file_name.capitalize!
    end
  end

  fixtures_names.each do |file_name| 
    Object.const_set file_name, Class.new(ActiveRecord::Base)
    set_fixture_class "#{file_name.downcase}".to_sym 
  end
  
  fixtures :all
  # Add more helper methods to be used by all tests here...

  include Rack::Test::Methods

  def app
    App
  end

  DatabaseCleaner.strategy = :transaction

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end