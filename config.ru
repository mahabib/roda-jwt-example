begin
  require_relative '.env'
rescue LoadError
  abort "\n.env.rb file does not exist. Please add it.\n\n"
end

puts "\n=========================\nENV - #{ENV['RACK_ENV']}\n#{Time.now}\n=========================\n\n"

require 'rack/reloader'
require_relative "app"

builder = Rack::Builder.new do
  use Rack::Reloader if ENV['RACK_ENV'] != 'production'
  run App.app
end
run builder.to_app