# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/invoices').to route_to('invoices#index')
    end

    it 'routes to #show' do
      expect(get: '/invoices/1').to route_to('invoices#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/invoices').to route_to('invoices#create')
    end

    it 'routes to #send_email' do
      expect(post: '/invoices/1/send_email').to route_to('invoices#send_email', invoice_id: '1')
    end
  end
end
