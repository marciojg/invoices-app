# frozen_string_literal: true

class AuthController < ApplicationController
  before_action :authenticated?, only: [:logout]

  def signup
    result = Auth::Signup::Process.call(params:)

    if result.success?
      render json: { data: { user: { email: result.data[:email] } } }, status: :ok
    else
      render json: { data: result.data }, status: :unprocessable_entity
    end
  end

  def login
    result = Auth::Login::Process.call(params:)

    if result.success?
      session[:current_user_email] = result.data[:user].email
      render json: { data: { login: true } }, status: :ok
    else
      render json: { data: result.data }, status: :bad_request
    end
  end

  def logout
    Current.user = session[:current_user_email] = nil
    render json: {}, status: :ok
  end

  def confirm_email
    result = Auth::ConfirmEmail::Process.call(params:)

    if result.success?
      session[:current_user_email] = result.data[:user].email
      render json: { data: { confirm_email: true } }, status: :ok
    else
      render json: { data: result.data }, status: :bad_request
    end
  end
end
