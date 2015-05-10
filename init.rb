# coding: utf-8
require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'mysql2'
require 'rubygems'
require 'data_mapper'
require 'json'
require 'rack-flash'
require './config/initializers/http_basic_auth.rb'
require './models/url_type'
require './models/group'
require './models/user'
require './models/url'
require './models/doctor'
require './models/metering'
require './models/analysis'
require './models/pacient'

enable :sessions
use Rack::Flash

=begin
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/base.db') 
DataMapper.finalize 
DataMapper.auto_upgrade!  
=end

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [HTTP_BASIC_AUTH['name'], HTTP_BASIC_AUTH['password']]
  end
end

get '/' do
  "Everybody can see this page"
end

get '/users/index_authenticated' do
  protected!
  @authenticated = true
  @users= User.all
end


get '/users/index_authenticated' do
  protected!
  @authenticated = true
  @users = User.all
end

post '/users/destroy/:id' do
  protected!
  @user = User.find(params[:id])
  @user.destroy
  flash[:notice] = 'Public user successfully destroyed.'
  redirect to("users/index_authenticated")

end

get '/users' do
  @users = User.all
  #erb :'users/index'
end

get '/users/new' do
  @user = User.new
  #erb :'users/new'
end

get '/users/:id' do
  @user = User.find(params[:id])
  #erb :'users/show'
end

post '/users/create' do
  @user = User.new(params[:user])
  if @user.save
    flash[:notice] = 'Public user successfully created!'
    redirect to("users/#{@user.id}")
  else
   # erb :'users/new'
  end
end
