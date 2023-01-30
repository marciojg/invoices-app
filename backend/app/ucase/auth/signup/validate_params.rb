# frozen_string_literal: true

module Auth::Signup
  class ValidateParams < Micro::Case
    attributes :params

    validates :params, kind: ActionController::Parameters

    def call!
      user_params = params.require(:user).permit(:email)

      Success result: { email: user_params[:email] }
    rescue ActionController::ParameterMissing => e
      Failure :parameter_missing, result: { message: e.message }
    end
  end
end
