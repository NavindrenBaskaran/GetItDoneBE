# JwtHelper to encode and decode tokens
class JwtHelper
  def self.encode(payload:, secret: Rails.application.secrets.secret_key_base,
                  algo: 'HS256')
    JWT.encode(payload, secret, algo)
  end

  def self.decode(token:, secret: Rails.application.secrets.secret_key_base,
                  algo: 'HS256')
    JWT.decode(token, secret, true, algorithm: algo)
  end
end
