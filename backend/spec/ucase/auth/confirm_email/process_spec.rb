# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::ConfirmEmail::Process do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    context 'with valid attributes' do
      let(:params) { ActionController::Parameters.new(email:, confirm_token:, renew:) }

      let(:user) { create(:user, confirm_token:, email_confirmed: false) }

      let(:email) { user.email }
      let(:confirm_token) { 'foo' }
      let(:renew) { true }

      it { expect(call.success?).to be true }
      it { expect(call.transitions.count).to eq(3) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          foo: 'foo@bar.com'
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.transitions.count).to eq(1) }
    end
  end
end
