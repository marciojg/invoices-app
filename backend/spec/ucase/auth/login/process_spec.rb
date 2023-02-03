# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Login::Process do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    context 'with valid attributes' do
      let(:params) { ActionController::Parameters.new(user: { email:, token: }) }

      let(:user) do
        create(
          :user,
          token: 'token',
          email_confirmed: true
        )
      end

      let(:email) { user.email }
      let(:token) { 'token' }

      it { expect(call.success?).to be true }
      it { expect(call.transitions.count).to eq(3) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          foo: { email: 'foo@teste.com', token: 'token' }
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.transitions.count).to eq(1) }
    end
  end
end
