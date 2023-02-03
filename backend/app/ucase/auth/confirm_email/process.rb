# frozen_string_literal: true

module Auth::ConfirmEmail
  class Process < Micro::Case
    flow Auth::ConfirmEmail::ValidateParams,
         Auth::ConfirmEmail::FindUser,
         Auth::ConfirmEmail::Confirm
  end
end
