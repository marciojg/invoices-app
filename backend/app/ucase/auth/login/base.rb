# frozen_string_literal: true

module Auth::Login
  class Base < Micro::Case
    attributes :email, :token, :user

    # TODO: To apply for all Micro::Case's
    def attributes
      super.transform_keys(&:to_sym)
    end
  end
end
