# frozen_string_literal: true

module Invoices::Creation
  class Base < Micro::Case
    attributes :number, :reference_date, :company_data, :billing_data, :value_cents, :emails
  end
end
