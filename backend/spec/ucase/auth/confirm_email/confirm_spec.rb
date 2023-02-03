# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::ConfirmEmail::Confirm do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    let(:params) do
      {
        email: user.email,
        confirm_token:,
        renew:,
        user:
      }
    end

    let(:user) do
      create(
        :user,
        email_confirmed: false,
        confirm_token: 'foo',
        renew_token: 'secure'
      )
    end

    context 'without valid confirm_token' do
      let(:confirm_token) { 'bar' }
      let(:renew) { false }

      it { expect(call.failure?).to be true }
      it { expect(call.type).to eq(:invalid_data) }
      it { expect(call.data[:message]).to eq('invalid confirm_token') }
    end

    context 'with valid confirm_token' do
      let(:confirm_token) { 'foo' }

      context 'when is a renew' do
        let(:renew) { true }

        it 'token must be replaced by renew_token' do
          call

          expect(user.authenticate_token('secure')).to be_present
        end

        it 'renew_token must be nil' do
          call

          expect(user.reload.renew_token_digest).to be_nil
        end

        it 'email_confirmed must be true' do
          call

          expect(user.reload.email_confirmed).to be_truthy
        end

        it { expect(call.success?).to be true }
        it { expect(call.data).to eq(params) }
      end

      context 'when is not a renew' do
        let(:renew) { false }

        it 'token must not be replaced by renew_token' do
          call

          expect(user.authenticate_token('secure')).not_to be_present
        end

        it 'renew_token must not be nil' do
          call

          expect(user.reload.renew_token_digest).to be_present
        end

        it 'email_confirmed must be true' do
          call

          expect(user.reload.email_confirmed).to be_truthy
        end

        it { expect(call.success?).to be true }
        it { expect(call.data).to eq(params) }
      end
    end
  end
end
