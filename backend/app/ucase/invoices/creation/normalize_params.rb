# frozen_string_literal: true

module Invoices::Creation
  class NormalizeParams < Base
    def call!
      normalized_emails = emails.map { |email| String(email).downcase.strip } if emails.present?

      Success result: attributes.merge(emails: normalized_emails)
    end
  end
end
