module JsonWebToken
  def self.encode(payload)
    payload[:exp] = Time.now.to_i + 24 * 3600 if !payload[:exp]
    payload[:exp].to_i!
    JWT.encode(payload, ENV['JWT_SECRET'], ENV['JWT_ALGO'])
  end

  def self.decode(token)
    decoded = JWT.decode(token, ENV['JWT_SECRET'])[0]
    HashWithIndifferentAccess.new decoded
  end
end