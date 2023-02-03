# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::ConfirmEmail::FindUser do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    let(:params) { { email: } }

    before { create(:user, email: 'foo@bar.com') }

    context 'with a valid email' do
      let(:email) { 'foo@bar.com' }

      it { expect(call.success?).to be true }
      it { expect(call.data[:user]).to be_instance_of(User) }
    end

    context 'with a invalid email' do
      context 'when the email is blank' do
        let(:email) { nil }

        it { expect(call.failure?).to be true }
        it { expect(call.type).to eq(:invalid_data) }
        it { expect(call.data[:email]).to be_nil }
      end

      context 'when the email is not a String' do
        let(:email) { 123 }

        it { expect(call.failure?).to be true }
        it { expect(call.type).to eq(:invalid_data) }
        it { expect(call.data[:email]).to eq(123) }
      end
    end

    context 'when not found' do
      let(:email) { 'anotherfoo@bar.com' }

      it { expect(call.success?).to be true }
      it { expect(call.data[:user]).to be_nil }
    end
  end
end
