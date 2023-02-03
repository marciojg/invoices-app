# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::ConfirmEmail::ValidateParams do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:params) do
      ActionController::Parameters.new(
        email:,
        confirm_token:,
        renew:
      )
    end

    let(:user) { create(:user, confirm_token:, email_confirmed: false) }

    context 'with valid attributes' do
      let(:email) { user.email }
      let(:confirm_token) { 'foo' }

      context 'when is a renewal of token' do
        let(:renew) { true }

        it { expect(call.success?).to be true }
        it { expect(call.data).to eq({ email:, confirm_token:, renew: }) }
      end

      context 'when is not a renewal of token' do
        let(:renew) { nil }

        it { expect(call.success?).to be true }
        it { expect(call.data).to eq({ email:, confirm_token:, renew: false }) }
      end
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          email: 'foo@bar.com',
          confirm_token: nil
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
