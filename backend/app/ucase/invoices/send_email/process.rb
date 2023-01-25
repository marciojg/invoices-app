# frozen_string_literal: true

module Invoices::SendEmail
  class Process < Base
    flow Invoices::SendEmail::ValidateParams,
         Invoices::SendEmail::NormalizeParams,
         Invoices::SendEmail::FindInvoice,
         Invoices::SendEmail::UpdateEmails,
         Invoices::SendEmail::Delivery
  end
end
