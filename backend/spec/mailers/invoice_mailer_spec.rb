# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceMailer do
  describe '#invoice_email' do
    let(:invoice) { create(:invoice) }
    let(:mail) { described_class.with(email: 'foo@bar.com', invoice:).invoice_email }

    context 'with headers renders' do
      it { expect(mail.subject).to eq("Invoice number: #{invoice.number}") }
      it { expect(mail.to).to eq(['foo@bar.com']) }
      it { expect(mail.from).to eq(['noreply@example.com']) }
    end

    context 'with body renders' do
      it { expect(mail.body.encoded).to match('This is your invoice') }
    end
  end
end
