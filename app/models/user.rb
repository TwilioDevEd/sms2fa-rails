require 'phony_rails'

class User < ActiveRecord::Base
  has_secure_password

  validates :first_name,
            :last_name,
            :email,
            :phone_number,
            :password_digest, presence: true

  validates_uniqueness_of :email

  def confirm!
    self.confirmed = true
    save!
  end

  def pretty_phone_number
    phone_number.phony_formatted(format: :international, spaces: ' ')
  end
end
