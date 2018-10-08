module Client
  module V1
    class Auth < Grape::API
      version 'v1'

      resource :user do
        desc 'Create User Account'

        params do
          requires :email, type: String
          requires :password, type: String
        end

        post :auth do

          response = Account::Auth.authenticate_user(email: params[:email], password:  params[:password])

          { status: 200, token: response.response[:jwt_token], response: response.message }
        end
      end
    end
  end
end
