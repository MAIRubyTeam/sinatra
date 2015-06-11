require_relative "#{__dir__}/config/init.rb"

Dir.glob("#{__dir__}/controllers/*.rb").each { |file_name| require_relative file_name }

class App < Sinatra::Base
	#set :views, settings.root + '/views'
	configure do
		set :root, File.dirname(__FILE__)
	end
	run! if __FILE__ == $0
end