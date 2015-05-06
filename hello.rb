# hello.rb
require 'sinatra'
require 'active_support/all'

Time::DATE_FORMATS[:my_datetime] = "%Y-%m-%d Hour: %H Minute: %M Second: %S"

get '/' do
  Time.now.to_s(:my_datetime)
end

not_found do
     status 404
     "Something wrong! Try to type URL correctly or call to UFO."
end

get "/:entity/:id" do
    #model = params[:entity].constantize
    #record = model.find(params[:id])

    #render json: record
   "{id: #{params[:id]}}"
end

