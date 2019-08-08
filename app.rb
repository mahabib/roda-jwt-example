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

  require_relative './helpers/utils'
  require_relative './helpers/json-web-token'

  error do |e|
    puts e.class, e.message, e.backtrace
    {
      success: false,
      error: e.message
    }
  end

  not_found do
    'where did it go?'
  end

  route do |r|
    @data = data = JSON.parse(request.body.read) rescue {}
	  request.body.rewind

    if ENV['RACK_ENV'] == 'development'
  	  puts "\n#{Time.now}\n#{request.request_method} #{request.path}\nxhr #{request.xhr?}"
  	  puts "params\n#{params}"
  	  puts "data\n#{data}"
      puts "env['HTTP_ACCEPT']\n#{env['HTTP_ACCEPT']}"
    end

    r.post "auth/login" do
      {
        success: true,
        values: User.login(params)
      }
    end

    r.on "users" do
      r.on String do |user_id|
        user = User[user_id]
        raise "Invalid User!" if !user

        r.get do
          {
            success: true,
            values: user.values
          }
        end

        r.put do
          user.update_user(params)
          {
            success: true
          }
        end

        r.delete do
          user.destroy
          {
            success: true
          }
        end
      end # /users/:id
      r.post do
        User.create_user(params)
        {
          success: true
        }
      end

      r.get do
        {
          success: true,
          values: User.all.collect{|u| u.values}
        }
      end
    end # /users
  end # /route
  
  
  def self.authorize_request req
    header = req.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end # App
