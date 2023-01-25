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

  describe 'GET /invoices/:id' do
    subject(:show) { get invoice_url(id), headers: }

    before do
      create_list(:invoice, 2)

      show
    end

    context 'with valid id' do
      let(:id) { Invoice.last.id }

      it { expect(response).to have_http_status :ok }
      it { expect(data['invoice']).not_to be_nil }
    end

    context 'with invalid id' do
      let(:id) { SecureRandom.uuid }

      it { expect(response).to have_http_status :not_found }
      it { expect(data['invoice']).to be_nil }
    end
  end

  describe 'POST /create' do
    subject(:create) { post invoices_url, headers:, params: }

    let(:params) { { invoice: invoice_attributes }.to_json }

    context 'with valid parameters' do
      let(:invoice_attributes) { attributes_for(:invoice) }

      it 'creates a new Invoice' do
        expect { create }.to change(Invoice, :count).by(1)
      end

      context 'with success response' do
        before { create }

        it { expect(response).to have_http_status :created }
        it { expect(data['invoice']).not_to be_nil }
      end
    end

    context 'with invalid parameters' do
      let(:invoice_attributes) { attributes_for(:invoice, number: nil) }

      it 'does not create a new Invoice' do
        expect { create }.not_to change(Invoice, :count)
      end

      context 'with errors response' do
        before { create }

        it { expect(response).to have_http_status :unprocessable_entity }
        it { expect(data['invoice']).to be_nil }
      end
    end
  end

  describe 'POST /invoices/:id/send_email' do
    subject(:send_email) { post invoice_send_email_url(id), headers:, params: }

    let(:params) { { invoice: { emails: } }.to_json }

    before { send_email }

    context 'with valid parameters' do
      let(:id) { create(:invoice).id }

      context 'with new emails' do
        let(:emails) { ['foo@bar.com'] }

        it { expect(response).to have_http_status :ok }
        it { expect(response.body.strip).to be_empty }
      end

      context 'without new emails' do
        let(:emails) { [] }

        it { expect(response).to have_http_status :ok }
        it { expect(response.body.strip).to be_empty }
      end
    end

    context 'with invalid parameters' do
      context 'when not found a resource' do
        let(:id) { SecureRandom.uuid }
        let(:emails) { [] }

        it { expect(response).to have_http_status :not_found }
      end

      context 'when has an invalid body' do
        let(:id) { create(:invoice).id }
        let(:params) { { foo: { emails: [] } }.to_json }

        it { expect(response).to have_http_status :internal_server_error }
      end
    end
  end
end
