configure :development do
  ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "127.0.0.1",
  :username => "root",
  :password => "1w1",
  :database => "database_development")
end

configure :test do
    ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database =>  'db/test.sqlite3.db')
end