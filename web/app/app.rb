#!/usr/bin/ruby

require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'logger'
require 'yaml'
require 'colorize'

require './libs/database'

db = @dbm.get_connection

configure do
  set :port, 55111
  set :bind, '0.0.0.0'
  set :views, 'views'
end

log = Logger.new('../logs/web.log')
log.debug 'hello'


# Get JSON Params (Sinatra bug work around)
def get_json_params
  JSON.parse(request.body.read)
end

get '/' do
  erb :front
end

# Feeds

get '/feeds' do
  @feeds = db[:feeds].order(Sequel.desc(:fid)).all
  erb :feeds
end

delete '/feeds/delete/:fid' do
  fid = params[:fid]
  db[:feeds].where(fid: fid).delete
  ':)'
end

post '/feeds/new' do
  jp = get_json_params
  db[:feeds].insert(name: jp['name'], link: jp['link'], tag: jp['tag'], description: jp['description'])
end

# Scopes

get '/scopes' do
  @keywords = Keywords.all
  @feeds = db[:feeds].order(:tag, :name).all
  puts @feeds.inspect
  erb :scopes
end

post '/scopes/new' do
  puts params.inspect.colorize(:red)
end