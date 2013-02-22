#!/usr/bin/env ruby
require 'sinatra'
require 'data_mapper'
require 'json'

# Rodrigo Rocha, started at November 19th, 2012
#
# See https://deploybutton.com/
# An online REST client: https://apigee.com/console/others

# Config for Cloud9 IDE (http://c9.io/)
set :port, ENV['PORT'] if ENV['PORT']
set :bind, ENV['IP'] if ENV['IP']

# Config for Heroku
database_url = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/database.db"

# Database configuration
DataMapper::setup(:default, database_url)

###################################################


before do
    content_type :json
    
    contents = request.body.read
    if contents && contents.size > 2
        begin
            @json_body = JSON.parse(contents)
            @json_body = @json_body.inject({ }) { |x, (k,v)| x[k.to_sym] = v; x }
    	    @json_body.delete(:id)
        rescue JSON::ParserError
        end
    end
end

get '/' do
	"Hello World"
end

get '/info' do
    database_url
end

#######################################################
# YOUR CODE HERE! #####################################
#######################################################

require_relative 'contatos'
#require_relative 'items'

#######################################################
#######################################################
#######################################################

DataMapper.finalize
DataMapper.auto_upgrade!
