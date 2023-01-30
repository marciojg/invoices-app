# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Signup::NormalizeParams do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    context 'when receiving the normalized emails' do
      let(:params) { { email: 'foo@bar.com' } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:email]).to eq(params[:email]) }
    end

    context 'when receiving the not normalized emails' do
      context 'with uppercase' do
        let(:params) { { email: 'FOO@Bar.com' } }

        it { expect(call.success?).to be true }
        it { expect(call.data[:email]).to eq('foo@bar.com') }
      end

      context 'with whitespaces' do
        let(:params) { { email: ' foo@Bar.com  ' } }

        it { expect(call.success?).to be true }
        it { expect(call.data[:email]).to eq('foo@bar.com') }
      end
    end
  end
end
