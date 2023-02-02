# frozen_string_literal: true

class AuthController < ApplicationController
  def signup
    result = Auth::Signup::Process.call(params:)

    if result.success?
      Current.user = result.data['user']
      render json: { data: { user: { email: result.data['email'] } } }, status: :ok
    else
      render json: { data: result.data }, status: :unprocessable_entity
    end
  end
end
