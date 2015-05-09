# coding: utf-8
require 'sinatra'
require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'carrierwave'
require 'carrierwave/datamapper'
require 'json'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/base.db') 
DataMapper.finalize 
DataMapper.auto_upgrade!  

class Post
  include DataMapper::Resource
  property :id, Serial 
  property :title, String 
  property :body, Text 
end

get '/' do
  'REST приложение на Sinatra <a href="/posts">Перейти к страницам</a>'
end

get '/posts/:id/edit' do
	<hh user=post> = Post.get(params[:id])
	erb :'posts/edit'
end

put '/posts/:id/edit' do
  post = Post.get(params[:id])
  post.title = (params[:title]) 
  post.body = (params[:body])
  post.save 
  redirect '/posts' 
end

get '/posts/:id/delete' do
  Post.get(params[:id]).destroy #удаляем пост
  redirect '/posts'
end

get '/posts/new' do 
  erb :'posts/new' 
end

post '/posts/new' do
	params.delete 'submit'
	<hh user=post> = Post.create(params)
	redirect '/posts'
end
