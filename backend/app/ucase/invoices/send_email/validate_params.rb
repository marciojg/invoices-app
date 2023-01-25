# frozen_string_literal: true

module Invoices::SendEmail
  class ValidateParams < Micro::Case
    attributes :params

    validates :params, kind: ActionController::Parameters

    def call!
      invoice_id_params = params.permit(:invoice_id)
      invoice_email_params = params.require(:invoice).permit(emails: [])

      Success result: { **invoice_id_params.merge(invoice_email_params) }
    rescue ActionController::ParameterMissing => e
      Failure :parameter_missing, result: { message: e.message }
    end
  end
end
