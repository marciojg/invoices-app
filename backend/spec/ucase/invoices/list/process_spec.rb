# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::List::Process do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    before do
      create(:invoice, number: 123_45, reference_date: Date.new(2023, 1, 20), value_cents: 5432)
      create(:invoice, number: 456_78, reference_date: Date.new(2023, 1, 18), value_cents: 2345)
    end

    context 'without params as filter' do
      let(:params) { {} }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoices].count).to eq(2) }
    end

    context 'when filtering by number' do
      let(:params) { { q: { number_eq: 123_45 } } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoices].count).to eq(1) }
    end

    context 'when filtering by reference_date' do
      let(:params) { { q: { reference_date_eq: '2023-1-20' } } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoices].count).to eq(1) }
    end

    context 'when filtering by another not allowed attribute' do
      let(:params) { { q: { value_cents_eq: 2345 } } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:invoices].count).to eq(2) }
    end
  end
end
