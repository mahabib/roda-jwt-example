App.route("auth") do |r|
  r.post "login" do
    {
      success: true,
      values: User.login(params)
    }
  end
end