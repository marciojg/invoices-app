# frozen_string_literal: true

module Auth::ConfirmEmail
  class Base < Micro::Case
    attributes :email, :confirm_token, :renew, :user

    # TODO: To apply for all Micro::Case's
    def attributes
      super.transform_keys(&:to_sym)
    end
  end
end
