# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Signup::ValidateParams do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:params) do
      ActionController::Parameters.new(
        user: user_hash
      )
    end

    context 'with valid attributes' do
      let(:user_hash) { { email: 'foo@bar.com' } }

      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq(user_hash) }
    end

    context 'with extra keys' do
      let(:permitted_attributes) { { email: 'foo@bar.com' } }
      let(:user_hash) { permitted_attributes.merge(foo_field: 'bar') }

      it { expect(call.success?).to be true }
      it { expect(call.data.transform_keys(&:to_sym)).to eq(permitted_attributes) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          foo: { email: 'foo@bar.com' }
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.data.key?(:message)).to be true }
    end
  end
end
