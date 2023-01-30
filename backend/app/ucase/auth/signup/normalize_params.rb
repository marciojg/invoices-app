# frozen_string_literal: true

module Auth::Signup
  class NormalizeParams < Base
    def call!
      normalized_email = String(email).downcase.strip if email.present?

      Success result: { email: normalized_email }
    end
  end
end
