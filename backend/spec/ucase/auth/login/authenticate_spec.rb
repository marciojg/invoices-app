# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Login::Authenticate do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    let(:params) do
      {
        email: user.email,
        token:,
        user:
      }
    end

    let(:user) do
      create(
        :user,
        email_confirmed: true,
        token: 'foo'
      )
    end

    context 'without valid token' do
      let(:token) { 'bar' }

      it { expect(call.failure?).to be true }
      it { expect(call.type).to eq(:invalid_data) }
      it { expect(call.data[:message]).to eq('invalid token') }
    end

    context 'with valid token' do
      let(:token) { 'foo' }

      it { expect(call.success?).to be true }
      it { expect(call.data).to eq(params) }
    end
  end
end
