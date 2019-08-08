require_relative '../app'

recs = [{
    :name=>'Habib',
    :email=>'habib@idefi.in',
    :password=>'habib@idefi.in',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Whitefield, Bangalore, India'
  }, {
    :name=>'Ahsan',
    :email=>'ahsan@idefi.in',
    :password=>'ahsan@idefi.in',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Whitefield, Bangalore, India'
  }, {
    :name=>'Gaurav',
    :email=>'gaurav@idefi.in',
    :password=>'gaurav@idefi.in',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Murgeshpalya, Bangalore, India'
  }, {
    :name=>'Mohan',
    :email=>'mohan@idefi.in',
    :password=>'mohan@idefi.in',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Domlur, Bangalore, India'
  }, {
    :name=>'Parneta',
    :email=>'parneta@idefi.in',
    :password=>'parneta@idefi.in',
    :gender=>'Female',
    :contact_no=>'9987654321',
    :address=>'Koramongala, Bangalore, India'
  }, {
    :name=>'Sagar',
    :email=>'sagar@idefi.in',
    :password=>'sagar@idefi.in',
    :gender=>'Male',
    :contact_no=>'9987654321',
    :address=>'Koramongala, Bangalore, India'
  }, {
    :name=>'Kanchan',
    :email=>'kanchan@idefi.in',
    :password=>'kanchan@idefi.in',
    :gender=>'Female',
    :contact_no=>'9987654321',
    :address=>'Kundalahalli, Bangalore, India'
  }]

recs.each do |rec|
  User.register(rec) if User.where(:email=>rec[:email]).count < 1
end