# frozen_string_literal: true

module Auth::Signup
  class RenewToken < Base
    def call!
      return Success result: attributes if user.blank?

      confirm_token, renew_token = Array.new(2) { SecureRandom.hex }

      user.update!(
        email_confirmed: false,
        confirm_token:,
        renew_token:
      )

      # It is necessary to send the `renew_token` and `confirm_token` because the attribute of the user is encrypted
      UserMailer.with(user: user.reload, renew_token:, confirm_token:).renew_registration.deliver_later
      Success result: attributes
    end
  end
end
