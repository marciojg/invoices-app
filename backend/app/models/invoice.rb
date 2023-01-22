# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :reference_date, :company_data, :billing_data, :emails, presence: true
  validates :number, :value_cents, numericality: { greater_than: 0 }
  validates :number, uniqueness: true
end
