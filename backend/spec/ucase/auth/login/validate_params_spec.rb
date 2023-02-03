# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Login::ValidateParams do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:params) { ActionController::Parameters.new(user: { email:, token: }) }

    let(:user) { create(:user, token:, email_confirmed: true) }

    context 'with valid attributes' do
      let(:email) { user.email }
      let(:token) { 'foo' }

      it { expect(call.success?).to be true }
      it { expect(call.data).to eq({ email:, token: }) }
    end

    context 'with invalid attributes' do
      let(:params) { ActionController::Parameters.new(foo: { email: 'foo@bar.com', token: nil }) }

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
