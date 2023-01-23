# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::SendEmail::UpdateEmails do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    let(:invoice) { create(:invoice, emails: ['teste@teste.com']) }
    let(:params) { { id: invoice.id, emails:, invoice: } }

    context 'with new emails' do
      let(:emails) { ['foo@bar.com'] }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoice]).to be_instance_of(Invoice) }
      it { expect(call.data[:invoice].emails).to eq(%w[teste@teste.com foo@bar.com]) }
    end

    context 'without emails' do
      context 'when emails is nil' do
        let(:emails) { nil }

        it { expect(call.success?).to be true }
        it { expect(call.data[:invoice]).to be_instance_of(Invoice) }
        it { expect(call.data[:invoice].emails).to eq(%w[teste@teste.com]) }
      end

      context 'when emails is a empty array' do
        let(:emails) { [] }

        it { expect(call.success?).to be true }
        it { expect(call.data[:invoice]).to be_instance_of(Invoice) }
        it { expect(call.data[:invoice].emails).to eq(%w[teste@teste.com]) }
      end
    end

    context 'when raise exception' do
      let(:emails) { ['foo@bar.com'] }

      before { allow(invoice).to receive(:update!).and_raise(StandardError) }

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
