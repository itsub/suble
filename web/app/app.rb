#!/usr/bin/ruby

require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'yaml'
require 'colorize'

configure do
  set :port, 55111
  set :bind, '0.0.0.0'
  set :views, 'views'
end

dbc = YAML.load_file('../config/database.yml')
db = Sequel.connect(adapter: dbc['adapter'], host: dbc['host'], database: dbc['database'], user: dbc['user'], password: dbc['password'])


# Get JSON Params (Sinatra bug work around)
def get_json_params
  JSON.parse(request.body.read)
end

get '/' do
  erb :front
end

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
