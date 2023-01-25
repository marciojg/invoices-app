# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invoices' do
  let(:headers) do
    {
      'ACCEPT' => 'application/json',
      'CONTENT_TYPE' => 'application/json'
    }
  end

  let(:data) { JSON.parse(response.body)['data'] }

  describe 'GET /invoices' do
    subject(:index) { get invoices_url, headers:, params: }

    let(:q) { {} }
    let(:params) { { q: } }

    before do
      create(:invoice)
      create(:invoice, number: 123_456, reference_date: '2020-10-10')

      index
    end

    context 'without filter' do
      it { expect(response).to have_http_status :ok }
      it { expect(data['invoices'].size).to eq 2 }
    end

    context 'with filter' do
      context 'when filtering by number' do
        let(:q) { { number_eq: 123_456 } }

        it { expect(data['invoices'].size).to eq 1 }
      end

      context 'when filtering by reference_date' do
        let(:q) { { reference_date_eq: '2020-10-10' } }

        it { expect(data['invoices'].size).to eq 1 }
      end
    end

    context 'with invalid filter' do
      let(:q) { { foo_eq: 'bar' } }

      it { expect(data['invoices'].size).to eq 2 }
    end
  end
end
