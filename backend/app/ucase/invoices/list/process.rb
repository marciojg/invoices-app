# frozen_string_literal: true

module Invoices::List
  class Process < Micro::Case
    attributes :params

    def call!
      query = Invoice.ransack(params[:q])

      Success result: { invoices: query.result }
    end
  end
end
