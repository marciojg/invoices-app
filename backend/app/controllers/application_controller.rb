# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authenticated?
    authenticate!

    return if Current.user.present?

    render json: { error: 'unauthorized' }, status: :unauthorized
  end

  def authenticate!
    return if session[:current_user_email].blank?

    Current.user ||= User.find_by(email: session[:current_user_email], email_confirmed: true)
  end
end
