#!/usr/bin/ruby

require 'sinatra'
require 'sequel'
require 'yaml'
require 'colorize'

configure do
  set :port, 55111
  set :bind, '0.0.0.0'
  set :views, 'views'
end

dbc = YAML.load_file('config/database.yml')
db = Sequel.connect(adapter: dbc['adapter'], host: dbc['host'], database: dbc['database'], user: dbc['user'], password: dbc['password'])


# Get JSON Params (Sinatra bug work around)
def get_json_params
  JSON.parse(request.body.read)
end

get '/' do
  erb :front
end

get '/feeds' do
  @feeds = db[:feeds].all
  puts @feeds.inspect.colorize(:yellow)
  erb :feeds
end

post '/feeds/new' do
  jp = get_json_params
  db[:feeds].insert(name: jp['name'], link: jp['link'], description: jp['description'])
end