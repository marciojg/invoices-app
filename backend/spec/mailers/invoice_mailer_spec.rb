# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceMailer do
  describe '#invoice_email' do
    let(:mail) { described_class.with(email: 'foo@bar.com').invoice_email }

    context 'with headers renders' do
      it { expect(mail.subject).to eq('Welcome to My Awesome Site') }
      it { expect(mail.to).to eq(['foo@bar.com']) }
      it { expect(mail.from).to eq(['notifications@example.com']) }
    end

    context 'with body renders' do
      it { expect(mail.body.encoded).to match('Welcome to example.com') }
    end
  end
end
