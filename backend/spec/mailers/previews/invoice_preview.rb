# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invoice
class InvoicePreview < ActionMailer::Preview
  def welcome_email
    InvoiceMailer.with(email: 'foo@bar.com').invoice_email
  end
end
