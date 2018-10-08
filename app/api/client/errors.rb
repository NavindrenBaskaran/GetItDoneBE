module Client
  module Errors
    extend ActiveSupport::Concern

    included do
      rescue_from InvalidCredentials do |e|
        error! e.message, 400
      end

      rescue_from WeakPasswordError do |e|
        error! e.message, 400
      end

      rescue_from InvalidEmailFormatError do |e|
        error! e.message, 400
      end

      rescue_from ActiveRecord::RecordNotUnique do |_|
        error! 'This e-mail is taken.', 409
      end

      rescue_from ActiveRecord::RecordNotFound do |_|
        error! 'There is no account associated with this email.', 400
      end

      rescue_from StandardError do |_|
        error! 'Internal Server Error.', 500
      end
    end
  end
end
