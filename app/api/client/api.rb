module Client
  class Api < Grape::API
    include Client::Errors

    prefix 'api'

    helpers do
    end

    mount V1::SignUp
    mount V1::Auth
  end
end
