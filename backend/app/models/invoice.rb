# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :company_data, :billing_data, :emails, presence: true
  validates :number, :value_cents, numericality: { greater_than: 0 }
  validates :number, uniqueness: true

  validate :validate_emails
  validate :validate_reference_date

  def self.ransackable_attributes(auth_object = nil)
    super & %w[number reference_date]
  end

  private

  def validate_emails
    return if emails.blank?
    return unless emails.any? { |email| (email =~ URI::MailTo::EMAIL_REGEXP).nil? }

    errors.add :emails, 'some of the ones are invalid'
  end

  def validate_reference_date
    Date.parse(reference_date.to_s)
  rescue
    errors.add :reference_date, 'is not a valid date'
  end
end
