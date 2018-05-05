module Account
  class Auth
    extend ServiceResponse

    def self.authenticate_user(email:, password:)
      email = email
      password = password

      @user = User.find_by! email: email.downcase
      raise 'Invalid Email/Password' unless @user.password == password

      expiration_date = Time.current.to_i * 3 * 60 * 60
      payload = { user_id: @user.id, exp: expiration_date }
      jwt_token = JwtHelper.encode(payload: payload)

      response(success: true, response: { token: jwt_token }, error: nil)
    rescue JWT::ExpiredSignature, RuntimeError, ActiveRecord::RecordNotFound => e
      response(success: false, response: nil, error: e.message)
    end

    def self.current_user(token:)
      payload, _header = JwtHelper.decode(token: token)
      @current_user = User.find_by! id: payload['user_id']

      response(success: false, response: @current_user, error: nil)
    rescue JWT::ExpiredSignature, RuntimeError, ActiveRecord::RecordNotFound => e
      response(success: false, response: nil, error: e.message)
    end
  end
end