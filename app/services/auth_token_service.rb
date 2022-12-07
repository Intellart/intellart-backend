class AuthTokenService
  require 'dotenv/load'

  API_KEY = ENV.fetch('API_KEY')
  ALGORITHM_TYPE = ENV.fetch('ALGORITHM_TYPE')

  def self.generate_jwt(user_id, domain, expiration = 5.minutes.from_now.to_i, admin: false)
    payload = if admin
                { admin_id: user_id, exp: expiration, domain: domain }
              else
                { user_id: user_id, exp: expiration, domain: domain }
              end
    JWT.encode payload, API_KEY, ALGORITHM_TYPE
  end

  def self.decode_jwt(token)
    JWT.decode token, API_KEY, ALGORITHM_TYPE
  end

  def self.save_expired_token(token)
    JwtDenylist.create!(jti: token, exp: Time.now)
  end
end
