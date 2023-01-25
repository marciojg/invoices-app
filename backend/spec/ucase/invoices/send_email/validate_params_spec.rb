# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::SendEmail::ValidateParams do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:invoice) { create(:invoice) }
    let(:emails) { ['teste@teste.com'] }

    let(:params) do
      ActionController::Parameters.new(
        invoice_id: invoice.id,
        invoice: { emails: }
      )
    end

    context 'with valid attributes' do
      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq({ invoice_id: invoice.id, emails: }) }
    end

    context 'without emails' do
      context 'when emails is nil' do
        let(:emails) { nil }

        it { expect(call.success?).to be true }
        it { expect(call.data.transform_keys(&:to_sym)).to eq({ invoice_id: invoice.id }) }
      end

      context 'when emails is a empty array' do
        let(:emails) { [] }
        let(:invoice_hash) { { invoice_id: invoice.id, emails: [] } }

        it { expect(call.success?).to be true }
        it { expect(call.data.transform_keys(&:to_sym)).to eq(invoice_hash) }
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          invoice_id: invoice.id,
          foo: { emails: }
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
