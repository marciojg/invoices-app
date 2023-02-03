# frozen_string_literal: true

module Auth::Signup
  class Process < Micro::Case
    flow Auth::Signup::ValidateParams,
         Auth::Signup::NormalizeParams,
         Auth::Signup::FindUser,
         Auth::Signup::RenewToken,
         Auth::Signup::Registration
  end
end
