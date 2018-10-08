module Client
  module V1
    class SignUp < Grape::API
      version 'v1'

      resource :user do
        desc 'Create User Account'

        params do
          requires :name, type: String
          requires :email, type: String
          requires :password, type: String
        end

        post :sign_up do
          name = params[:name]
          email = params[:email]
          password = params[:password]

          response = Account::CreateUser.new(name: name,
                                             email: email,
                                             password: password).call
          { status: 200, token: response.response[:jwt_token], response: response.message }
        end
      end
    end
  end
end
