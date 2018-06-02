module Client
  module Errors
    extend ActiveSupport::Concern

    included do
      rescue_from InvalidCredentials do |e|
        error!(status: 400, message: e.message)
      end

      rescue_from WeakPasswordError do |e|
        error!(status: 400, message: e.message)
      end

      rescue_from InvalidEmailFormatError do |e|
        error!(status: 400, message: e.message)
      end

      rescue_from ActiveRecord::RecordNotUnique do |_|
        error!(status: 409, message: 'This e-mail is taken.')
      end

      rescue_from ActiveRecord::RecordNotFound do |_|
        error!(status: 400, message: 'There is no account associated with this email.')
      end

      rescue_from StandardError do |_|
        error!(status: 500, message: 'Internal Server Error.')
      end
    end
  end
end
