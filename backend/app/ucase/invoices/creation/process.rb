# frozen_string_literal: true

module Invoices::Creation
  class Process < Micro::Case
    flow Invoices::Creation::ValidateParams,
         Invoices::Creation::NormalizeParams,
         Invoices::Creation::Persist
  end
end
