# Validate the given email format
class EmailValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate(record)
    record.errors.add(:email, 'Invalid Email!') unless record.email =~
    VALID_EMAIL_REGEX
  end
end
