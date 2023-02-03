# frozen_string_literal: true

class AuthController < ApplicationController
  def signup
    result = Auth::Signup::Process.call(params:)

    if result.success?
      Current.user = result.data[:user]
      render json: { data: { user: { email: result.data[:email] } } }, status: :ok
    else
      render json: { data: result.data }, status: :unprocessable_entity
    end
  end


  def logout
    Current.user = nil
    render json: {}, status: :ok
  end

  def confirm_email
    result = Auth::ConfirmEmail::Process.call(params:)

    if result.success?
      Current.user = result.data[:user]
      render json: { data: { confirm_email: true } }, status: :ok
    else
      render json: { data: result.data }, status: :bad_request
    end
  end
end
