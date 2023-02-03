# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password :token
  has_secure_password :renew_token, validations: false
  has_secure_password :confirm_token, validations: false

  validates :email, presence: true, uniqueness: true
  validate :validate_email

  private

  def validate_email
    return if email.present? && !(email =~ URI::MailTo::EMAIL_REGEXP).nil?

    errors.add :email, 'is invalid'
  end
end
