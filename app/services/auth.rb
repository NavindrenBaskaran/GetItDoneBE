class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :validate_credentials, only: [:authenticate_user]

  attr_reader :user

  def authenticate_user
    email = params[:email]
    password = params[:password]

    @user = User.find_by! email: email

    raise 'Invalid Email/Password' unless user.password == password

    render json: { auth_token: jwt_token }

  rescue RuntimeError, ActiveRecord::RecordNotFound
    redirect_to_login
  end

  def jwt_token
    JwtHelper.encode(payload: payload)
  end

  def payload
    {
      user_id: @user.id
    }
  end

  def current_user
    if token_present?
      payload, _header = JwtHelper.decode(params[:token])
      user_id = payload['user_id']
      @user = User.find!(user_id)
    end
  rescue RuntimeError, ActiveRecord::RecordNotFound
    redirect_to_login
  end

  def token_present?
    raise 'Token missing!' unless params[:token].present?
    true
  end

  def redirect_to_login
    redirect_to root_path
  end

  def validate_credentials
    raise 'Email and Password are required' unless params[:email].present? ||
                                                   params[:password].present?
  end
end
