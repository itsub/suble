#!/usr/bin/ruby

require 'sinatra'

get '/'
  :hello.to_s
end

run Sinatra.Application
