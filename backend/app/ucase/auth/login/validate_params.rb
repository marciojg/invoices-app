# frozen_string_literal: true

module Auth::Login
  class ValidateParams < Micro::Case
    attributes :params

    validates :params, kind: ActionController::Parameters

    def call!
      login_params = params.require(:user).permit(:email, :token)

      Success result: { email: login_params[:email], token: login_params[:token] }
    rescue ActionController::ParameterMissing => e
      Failure :parameter_missing, result: { message: e.message }
    end
  end
end
