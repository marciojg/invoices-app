# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :reference_date, :company_data, :billing_data, :emails, presence: true
  validates :number, :value_cents, numericality: { greater_than: 0 }
  validates :number, uniqueness: true

  validate :validate_emails

  private

  def validate_emails
    return if emails.blank?
    return unless emails.any? { |email| (email =~ URI::MailTo::EMAIL_REGEXP).nil? }

    errors.add :emails, 'some of the emails are invalid'
  end
end
