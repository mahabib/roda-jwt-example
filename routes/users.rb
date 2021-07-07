App.route("users") do |r|
  data = @data

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
      token = r.headers['Authorization'] ||  params[:token] || data[:token] || nil
      @current_user = JsonWebToken.authorize_request(token)
      user.update_user(params)
      {
        success: true
      }
    end

    r.delete do
      token = r.headers['Authorization'] ||  params[:token] || data[:token] || nil
      @current_user = JsonWebToken.authorize_request(token)
      user.destroy
      {
        success: true
      }
    end
  end # /users/:id
  r.post do
    User.create_user(data)
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