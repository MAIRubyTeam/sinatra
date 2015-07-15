ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'arel'
require 'json'
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
  include Rack::Test::Methods

  self.fixture_path = "./test/fixtures/"
  self.use_transactional_fixtures = true

  DatabaseCleaner.strategy = :transaction

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

  fixtures :all

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
    set_fixture_class "#{file_name.downcase}".to_sym => Object.const_get(file_name)
  end

  def check_data(result, real_result)
    result[:columns].each_index do |i|
      assert_equal real_result.columns[i], result[:columns][i]
    end

    result[:rows].each_index do |i|
      result[:rows][i].each_index do |j|
        assert_equal real_result.rows[i][j], result[:rows][i][j]
      end
    end
  end

  def parse_response_json(body)
    data = ActiveSupport::JSON.decode(body)

    if (data.class == Hash)
      data = [data]
    end

    rows = []
    columns = [] 

    data.each do |row|
      print "ROW "
      p row
      temp_row = []
      row.each_pair do |col, val|
        print "COL VAL "
        print col
        p val
        columns << col unless columns.include? col
        temp_row << val
      end
      rows << temp_row
    end
    {columns: columns, rows: rows,  data: data }
  end

  def app
    App
  end

end