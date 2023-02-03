# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def registration_confirmation
    @user, @token, @confirm_token = params[:user], params[:token], params[:confirm_token]
    mail(to: @user.email, subject: 'Registration Confirmation')
  end

  def renew_registration
    @user, @renew_token, @confirm_token = params[:user], params[:renew_token], params[:confirm_token]
    mail(to: @user.email, subject: 'Renew your registration')
  end
end
