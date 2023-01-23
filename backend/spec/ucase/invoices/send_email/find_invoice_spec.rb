# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::SendEmail::FindInvoice do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    let(:params) { { id:, emails: ['foo@bar.com'] } }

    before { create(:invoice) }

    context 'with a valid id' do
      let(:id) { Invoice.last.id }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoice]).to be_instance_of(Invoice) }
    end

    context 'with a invalid id' do
      context 'when the id is blank' do
        let(:id) { nil }

        it { expect(call.failure?).to be true }
        it { expect(call.type).to eq(:invalid_data) }
        it { expect(call.data[:id]).to be_nil }
      end

      context 'when the id is not a String' do
        let(:id) { 123 }

        it { expect(call.failure?).to be true }
        it { expect(call.type).to eq(:invalid_data) }
        it { expect(call.data[:id]).to eq(123) }
      end
    end

    context 'when not found' do
      let(:id) { SecureRandom.uuid }

      it { expect(call.failure?).to be true }
      it { expect(call.type).to eq(:record_not_found) }
    end
  end
end
