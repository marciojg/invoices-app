# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def registration_confirmation
    @user, @token = params[:user], params[:token]
    mail(to: @user.email, subject: 'Registration Confirmation')
  end

  def renew_registration
    @user, @renew_token = params[:user], params[:renew_token]
    mail(to: @user.email, subject: 'Renew your registration')
  end
end
