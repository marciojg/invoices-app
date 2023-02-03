# frozen_string_literal: true

module Invoices::SendEmail
  class Delivery < Base
    def call!
      invoice.emails.each do |email|
        InvoiceMailer.with(email:, invoice:).invoice_email.deliver_later
      end

      Success result: { **attributes }
    rescue => e
      Failure result: { message: e.message }
    end
  end
end
