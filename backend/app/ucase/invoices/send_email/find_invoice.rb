# frozen_string_literal: true

module Invoices::SendEmail
  class FindInvoice < Base
    def call!
      if invoice_id.present? && invoice_id.is_a?(String)
        invoice = Invoice.find(invoice_id)

        Success result: { **attributes.merge(invoice:) }
      else
        Failure :invalid_data, result: { invoice_id: }
      end
    rescue ActiveRecord::RecordNotFound
      Failure :record_not_found
    end
  end
end
