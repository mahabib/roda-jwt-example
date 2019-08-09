require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'models'

class App < Roda
  plugin :indifferent_params
  plugin :all_verbs
  plugin :not_found
  plugin :error_handler
  plugin :json
  use Rack::Session::Cookie, secret: ENV['RACK_SECRET'], key: ENV['RACK_SECRET_KEY']

  use Rack::Protection
  plugin :route_csrf
  plugin :multi_route
  plugin :request_headers

  error do |e|
    puts e.class, e.message, e.backtrace
    { success: false, error: e.message }
  end

  not_found do
    'where did it go?'
  end

  Dir['./routes/*.rb'].each{|f| require f}

  route do |r|
    @data = data = JSON.parse(request.body.read) rescue {}
	  request.body.rewind

    if ENV['RACK_ENV'] == 'development'
  	  puts "\n#{Time.now}\n#{request.request_method} #{request.path}\nxhr #{request.xhr?}"
  	  puts "params\n#{params}"
  	  puts "data\n#{data}"
    end

    r.multi_route
  end # /route
end # App
