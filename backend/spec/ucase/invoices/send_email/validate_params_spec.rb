# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::SendEmail::ValidateParams do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:params) do
      ActionController::Parameters.new(
        invoice: invoice_hash
      )
    end

    let(:invoice_hash) { { id: create(:invoice).id, emails: ['teste@.teste.com'] } }

    context 'with valid attributes' do
      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq(invoice_hash) }
    end

    context 'without emails' do
      context 'when emails is nil' do
        let(:invoice) { create(:invoice) }
        let(:invoice_hash) { { id: invoice.id, emails: nil } }

        it { expect(call.success?).to be true }
        it { expect(call.data.transform_keys(&:to_sym)).to eq({ id: invoice.id }) }
      end

      context 'when emails is a empty array' do
        let(:invoice) { create(:invoice) }
        let(:invoice_hash) { { id: invoice.id, emails: [] } }

        it { expect(call.success?).to be true }
        it { expect(call.data.transform_keys(&:to_sym)).to eq(invoice_hash) }
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          foo: invoice_hash
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
