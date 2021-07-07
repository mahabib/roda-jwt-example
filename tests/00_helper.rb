ENV['RACK_ENV'] = 'test'

begin
  require_relative '../.env'
rescue LoadError
  abort "\n.env.rb file does not exist. Please add it.\n\n"
end

puts "\n=========================\nENV - #{ENV['RACK_ENV']}\n#{Time.now}\n=========================\n\n"

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
# require 'fileutils'

require_relative "../app"

def create_test_data
  puts "create_test_data..."

  recs = [{
    :name=>'Habib',
    :email=>'habib@mail.com',
    :password=>'habib@mail.com',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Whitefield, Bangalore, India'
  }, {
    :name=>'Ahsan',
    :email=>'ahsan@mail.com',
    :password=>'ahsan@mail.com',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Whitefield, Bangalore, India'
  }]

  recs.each do |rec|
    User.create_user(rec) if User.where(:email=>rec[:email]).count < 1
  end
end