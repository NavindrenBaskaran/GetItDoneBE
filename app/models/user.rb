# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  email         :string           not null
#  password_hash :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ApplicationRecord
  include BCrypt
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}/

  validate :valid_email?

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(password)
    return unless valid_password? password
    @password = Password.create(password)
    self.password_hash = @password
  end

  private

  def valid_email?
    return true if email =~ EMAIL_REGEX
    errors.add(:email, 'Invalid Email!')
    raise InvalidEmailFormatError, 'Invalid Email!'
  end

  def valid_password?(password)
    return true if password =~ PASSWORD_REGEX
    raise WeakPasswordError, password_error
  end

  def password_error
    (['Password should atleast be 8 characters long, should '] +
     ['contain one lowercase character, one uppercase character, '] +
     ['a number and a special character!']).join
  end
end
