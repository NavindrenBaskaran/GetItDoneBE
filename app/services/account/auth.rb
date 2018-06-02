module Account
  class Auth
    extend ServiceResponse

    def self.authenticate_user(email:, password:)
      @user = User.find_by! email: email.downcase

      raise InvalidCredentials, 'Invalid Email/Password' unless @user.password == password
      payload = Account::DefaultPayload.payload(user: @user)
      jwt_token = JwtHelper.encode(payload: payload)
      response(success: true, response: { jwt_token: jwt_token }, message: nil)
    end
  end
end
