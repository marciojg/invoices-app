# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authenticated?
    authenticate!

    render json: { error: 'unauthorized' }, status: :unauthorized if Current.user.blank?
  end

  def authenticate!
    return if Current.user.present?

    user = User.find_by(email: current_user_email, email_confirmed: true)

    return if user.blank?

    Current.user = user if user.authenticate_token(current_user_token)
  end

  def current_user_email
    request.headers['x-client']
  end

  def current_user_token
    request.headers['x-access-token']
  end
end
