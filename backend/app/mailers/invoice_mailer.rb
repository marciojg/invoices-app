# frozen_string_literal: true

class InvoiceMailer < ApplicationMailer
  def invoice_email
    @email, @invoice = params[:email], params[:invoice]
    attachments['invoice.pdf'] = File.read('public/example.pdf')
    mail(to: @email, subject: "Invoice number: #{@invoice.number}")
  end
end
