# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::SendEmail::Process do
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
      it { expect(call.transitions.count).to eq(5) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          invoice_id: invoice.id,
          foo: { emails: }
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.transitions.count).to eq(1) }
    end
  end
end
