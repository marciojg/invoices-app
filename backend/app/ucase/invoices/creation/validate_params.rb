# frozen_string_literal: true

module Invoices::Creation
  class ValidateParams < Micro::Case
    attributes :params

    validates :params, kind: ActionController::Parameters

    def call!
      invoice_params = params.require(:invoice).permit(
        :number, :reference_date, :company_data, :billing_data, :value_cents, emails: []
      )

      Success result: { **invoice_params }
    rescue ActionController::ParameterMissing => e
      Failure :parameter_missing, result: { message: e.message }
    end
  end
end
