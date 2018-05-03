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

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(password)
    @password = Password.create(password)
    self.password_hash = @password
  end
end
