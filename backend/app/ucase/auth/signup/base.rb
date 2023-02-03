# frozen_string_literal: true

module Auth::Signup
  class Base < Micro::Case
    attributes :email, :user

    # TODO: To apply for all Micro::Case's
    def attributes
      super.transform_keys(&:to_sym)
    end
  end
end
