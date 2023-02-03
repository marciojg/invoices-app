# frozen_string_literal: true

module Auth::Login
  class Authenticate < Base
    def call!
      if user.authenticate_token(token).present?
        Success result: attributes
      else
        Failure :invalid_data, result: { message: 'invalid token' }
      end
    end
  end
end
