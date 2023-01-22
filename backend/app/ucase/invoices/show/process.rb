# frozen_string_literal: true

module Invoices::Show
  class Process < Micro::Case
    attributes :id

    def call!
      if id.present? && id.is_a?(String)
        invoice = Invoice.find(id)

        Success result: { invoice: }
      else
        Failure :invalid_data, result: { id: }
      end
    rescue ActiveRecord::RecordNotFound
      Failure :record_not_found
    end
  end
end
