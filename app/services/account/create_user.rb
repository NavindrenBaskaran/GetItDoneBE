module Account
  class CreateUser
    include ServiceResponse

    def initialize(name:, email:, password:)
      @name = name
      @email = email
      @password = password
    end

    def call
      ActiveRecord::Base.transaction do
        create_user
        issue_jwt_token
        response(success: true, response: success_response, message: 'Account created!')
      end
    end

    private

    def create_user
      @user = User.new(user_params)
      @user.password = @password
      @user.save!
    end

    def user_params
      {
        name: @name,
        email: @email.downcase
      }
    end

    def payload
      Account::DefaultPayload.payload(user: @user)
    end

    def issue_jwt_token
      @jwt_token ||= Account::JwtHelper.encode(payload: payload)
    end

    def success_response
      {
        user: @user,
        jwt_token: @jwt_token
      }
    end
  end
end
