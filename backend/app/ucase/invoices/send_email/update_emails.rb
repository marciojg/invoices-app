# frozen_string_literal: true

module Invoices::SendEmail
  class UpdateEmails < Base
    def call!
      update_invoice!
      Success result: { **attributes.merge(invoice: invoice.reload) }
    rescue => e
      Failure result: { message: e.message }
    end

    private

    def update_invoice!
      return if emails.blank?

      invoice.update!(emails: invoice.emails | emails)
    end
  end
end
