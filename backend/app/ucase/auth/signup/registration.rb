# frozen_string_literal: true

module Auth::Signup
  class Registration < Base
    def call!
      return Success result: attributes if user.present?

      token, confirm_token = Array.new(2) { SecureRandom.hex }

      new_user = User.create!(email:, token:, confirm_token:)

      # It is necessary to send the `token` as a parameter because the attribute of the user is encrypted
      UserMailer.with(user: new_user.reload, token:).registration_confirmation.deliver_later
      Success result: attributes.merge(user: new_user)
    end
  end
end
