# frozen_string_literal: true

module Invoices::SendEmail
  class Base < Micro::Case
    attributes :id, :emails, :invoice
  end
end
