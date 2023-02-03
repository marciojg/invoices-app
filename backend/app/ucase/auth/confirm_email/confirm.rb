# frozen_string_literal: true

module Auth::ConfirmEmail
  class Confirm < Base
    def call!
      if user.authenticate_confirm_token(confirm_token).blank?
        return Failure :invalid_data, result: { message: 'invalid confirm_token' }
      end

      if renew
        user.token_digest = user.renew_token_digest
        user.renew_token_digest = nil
      end

      user.email_confirmed = true
      user.save!

      Success result: attributes
    end
  end
end
