# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Signup::RenewToken do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    context 'without the user in the params' do
      let(:params) { { email: 'foo@bar.com' } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:email]).to eq(params[:email]) }
      it { expect(call.data[:user]).to be_nil }

      it 'not update the tokens of user' do
        allow(User).to receive(:update!)

        expect(User).not_to have_received(:update!)
      end

      it 'not enqueue a renew registration email' do
        expect { call }.not_to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end

    context 'with the user in the params' do
      let(:params) { { email: 'foo@bar.com', user: create(:user) } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:email]).to eq(params[:email]) }
      it { expect(call.data[:user]).to be_instance_of(User) }

      it { expect(call.data[:user].email_confirmed).to be_falsey }

      it 'enqueue a renew registration email' do
        expect { call }.to have_enqueued_job(
          ActionMailer::MailDeliveryJob
        ).with('UserMailer', 'renew_registration', any_args)
      end
    end
  end
end
