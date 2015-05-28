configure :development do
  ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "127.0.0.1",
  :username => "test",
  :password => "11111111",
  :database => "ambulance")
end

configure :test do
    ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database =>  'db/test.sqlite3.db')
end
