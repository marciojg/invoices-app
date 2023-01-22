# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::Creation::Persist do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    context 'with valid attributes' do
      let(:params) { attributes_for(:invoice) }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoice]).to be_instance_of(Invoice) }
    end

    context 'with invalid attributes' do
      let(:params) { attributes_for(:invoice, reference_date: nil) }

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
