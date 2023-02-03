# frozen_string_literal: true

module Auth::Login
  class FindUser < Base
    def call!
      if email.present? && email.is_a?(String)
        user = User.find_by!(email:, email_confirmed: true)

        Success result: { **attributes.merge(user:) }
      else
        Failure :invalid_data, result: { email: }
      end
    rescue ActiveRecord::RecordNotFound
      Failure :record_not_found
    end
  end
end
