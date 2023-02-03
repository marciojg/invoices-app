# frozen_string_literal: true

module Auth::Login
  class Process < Micro::Case
    flow Auth::Login::ValidateParams,
         Auth::Login::FindUser,
         Auth::Login::Authenticate
  end
end
