# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Signup::Process do
  describe '.call' do
    subject(:call) { described_class.call(params:) }

    let(:params) do
      ActionController::Parameters.new(
        user: user_hash
      )
    end

    let(:user_hash) { { email: 'foo@bar.com' } }

    context 'with valid attributes' do
      it { expect(call.success?).to be true }
      it { expect(call.transitions.count).to eq(5) }
    end

    context 'with invalid attributes' do
      let(:params) do
        ActionController::Parameters.new(
          foo: user_hash
        )
      end

      it { expect(call.failure?).to be true }
      it { expect(call.transitions.count).to eq(1) }
    end
  end
end
