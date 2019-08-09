App.route("users") do |r|
  r.on String do |user_id|
    r.get do
      user = User[user_id]
      raise "Invalid User!" if !user
      {
        success: true,
        values: user.values
      }
    end

    r.put do
      @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
      user.update_user(params)
      {
        success: true
      }
    end

    r.delete do
      @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
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
end