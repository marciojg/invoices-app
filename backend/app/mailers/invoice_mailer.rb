# frozen_string_literal: true

class InvoiceMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def invoice_email
    @email = params[:email]
    @url = 'http://example.com/login'
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end
end
