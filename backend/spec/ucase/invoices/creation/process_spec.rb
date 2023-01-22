# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::Creation::Process do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    context 'with valid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          invoice: attributes_for(:invoice)
        )
      end

      it { expect(call.success?).to be true }
      it { expect(call.transitions.count).to eq(3) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          invoice: attributes_for(:invoice, reference_date: nil)
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.transitions.count).to eq(3) }
    end
  end
end
