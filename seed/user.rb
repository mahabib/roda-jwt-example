require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative '../models'

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
}, {
  :name=>'Gaurav',
  :email=>'gaurav@mail.com',
  :password=>'gaurav@mail.com',
  :gender=>'Male',
  :contact_no=>'9987654321',
  :address=>'Murgeshpalya, Bangalore, India'
}, {
  :name=>'Mohan',
  :email=>'mohan@mail.com',
  :password=>'mohan@mail.com',
  :gender=>'Male',
  :contact_no=>'9987654321',
  :address=>'Domlur, Bangalore, India'
}, {
  :name=>'Parneta',
  :email=>'parneta@mail.com',
  :password=>'parneta@mail.com',
  :gender=>'Female',
  :contact_no=>'9987654321',
  :address=>'Koramongala, Bangalore, India'
}, {
  :name=>'Sagar',
  :email=>'sagar@mail.com',
  :password=>'sagar@mail.com',
  :gender=>'Male',
  :contact_no=>'9987654321',
  :address=>'Koramongala, Bangalore, India'
}, {
  :name=>'Kanchan',
  :email=>'kanchan@mail.com',
  :password=>'kanchan@mail.com',
  :gender=>'Female',
  :contact_no=>'9987654321',
  :address=>'Kundalahalli, Bangalore, India'
}]

recs.each do |rec|
  User.create_user(rec) if User.where(:email=>rec[:email]).count < 1
end