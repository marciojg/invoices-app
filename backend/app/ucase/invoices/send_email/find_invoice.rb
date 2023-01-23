# frozen_string_literal: true

module Invoices::SendEmail
  class FindInvoice < Base
    def call!
      if id.present? && id.is_a?(String)
        invoice = Invoice.find(id)

        Success result: { **attributes.merge(invoice:) }
      else
        Failure :invalid_data, result: { id: }
      end
    rescue ActiveRecord::RecordNotFound
      Failure :record_not_found
    end
  end
end
