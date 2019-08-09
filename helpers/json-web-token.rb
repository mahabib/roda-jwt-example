module JsonWebToken
  def self.encode(payload, exp = Time.now + 86400)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV['JWT_SECRET'], ENV['JWT_ALGO'])
  end

  def self.decode(token)
    verify = true
    JWT.decode(token, ENV['JWT_SECRET'], verify, { :algorithm => ENV['JWT_ALGO'] })[0]
  end

  def self.authorize_request token
    token = token.split(' ').last if token
    begin
      decoded = JsonWebToken.decode(token)
      current_user = User[decoded['user_id']]
      raise "Invalid User!" if !current_user
    rescue JWT::DecodeError => e
      raise e.message
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise e.message
    rescue Sequel::Error => e
      raise e.message
    rescue Exception => e
      raise e.message
    end
    current_user
  end
end