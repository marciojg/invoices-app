# frozen_string_literal: true

module Invoices::Creation
  class Persist < Base
    def call!
      invoice = Invoice.create!(attributes)

      Success result: { invoice: }
    rescue => e
      Failure result: { message: e.message }
    end
  end
end
