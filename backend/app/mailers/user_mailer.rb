# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def registration_confirmation
    @user, @token = params[:user], params[:token]
    mail(to: @user.email, subject: 'Registration Confirmation')
  end
end
