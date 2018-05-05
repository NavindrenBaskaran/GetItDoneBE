module Account
  class CreateUser
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      validate_email
      validate_password
      create_user
      issue_jwt_token
    end

    private

    def validate_email
    end

    def validate_password
    end

    def create_user
    end

    def issue_jwt_token
    end
  end
end
