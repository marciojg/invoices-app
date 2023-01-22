# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoices::Creation::NormalizeParams do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    context 'when receiving the normalized emails' do
      let(:params) { { emails: ['foo@bar.com', 'bar@foo.com'] } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:emails]).to eq(params[:emails]) }
    end

    context 'when receiving the not normalized emails' do
      context 'with uppercase' do
        let(:params) { { emails: ['FOO@Bar.com'] } }

        it { expect(call.success?).to be true }
        it { expect(call.data[:emails]).to eq(['foo@bar.com']) }
      end

      context 'with whitespaces' do
        let(:params) { { emails: [' foo@Bar.com  '] } }

        it { expect(call.success?).to be true }
        it { expect(call.data[:emails]).to eq(['foo@bar.com']) }
      end
    end
  end
end
