# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::Creation::ValidateParams do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:params) do
      ActionController::Parameters.new(
        invoice: invoice_hash
      )
    end

    context 'with valid attributes' do
      let(:invoice_hash) { attributes_for(:invoice) }

      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq(invoice_hash) }
    end

    context 'with all keys' do
      let(:invoice_hash) { attributes_for(:invoice, reference_date: nil) }

      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq(invoice_hash) }
    end

    context 'with extra keys' do
      let(:permitted_attributes) { attributes_for(:invoice) }
      let(:invoice_hash) { permitted_attributes.merge(foo_field: 'bar') }

      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq(permitted_attributes) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          foo: attributes_for(:invoice)
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
