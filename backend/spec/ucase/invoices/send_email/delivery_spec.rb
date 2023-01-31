# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::SendEmail::Delivery do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    let(:invoice) { create(:invoice, emails: ['foo@bar.com']) }
    let(:params) { { id: invoice.id, emails: [], invoice: } }

    context 'when delivery with success' do
      it 'enqueue an invoice email' do
        expect { call }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end

      it { expect(call.success?).to be true }
    end

    context 'when raise exception' do
      before { allow(InvoiceMailer).to receive(:with).with(email: 'foo@bar.com').and_raise(StandardError) }

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
