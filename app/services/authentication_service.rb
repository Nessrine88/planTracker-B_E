# app/services/authentication_service.rb
class AuthenticationService
    ACCESS_TOKEN_EXPIRATION = 1.days
    REFRESH_TOKEN_EXPIRATION = 30.days
  
    def self.encode_access_token(user_id)
      payload = { user_id: user_id, exp: ACCESS_TOKEN_EXPIRATION.from_now.to_i }
      JWT.encode(payload, Rails.application.secret_key_base)
    end
  
    def self.encode_refresh_token(user_id)
      payload = { user_id: user_id, exp: REFRESH_TOKEN_EXPIRATION.from_now.to_i }
      JWT.encode(payload, Rails.application.secret_key_base)
    end
  
    def self.decode_token(token)
      begin
        JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
      rescue JWT::DecodeError => e
        nil
      end
    end
  
    def self.decode_refresh_token(token)
      self.decode_token(token)
    end
  end
  