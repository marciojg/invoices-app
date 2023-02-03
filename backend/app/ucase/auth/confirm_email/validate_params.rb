# frozen_string_literal: true

module Auth::ConfirmEmail
  class ValidateParams < Micro::Case
    attributes :params

    validates :params, kind: ActionController::Parameters

    def call!
      email = params.require(:email)
      confirm_token = params.require(:confirm_token)
      renew_params = params.permit(:renew)

      Success result: { email:, confirm_token:, renew: renew_params[:renew] || false }
    rescue ActionController::ParameterMissing => e
      Failure :parameter_missing, result: { message: e.message }
    end
  end
end
