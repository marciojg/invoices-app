# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Signup::Registration do
  describe '.call' do
    subject(:call) { described_class.call(**params) }

    context 'with the user in the params' do
      let(:params) { { email: 'foo@bar.com', user: create(:user) } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:email]).to eq(params[:email]) }
      it { expect(call.data[:user]).to be_instance_of(User) }

      it 'not create a new user' do
        allow(User).to receive(:create!)

        expect(User).not_to have_received(:create!)
      end

      it 'not enqueue a registration confirmation email' do
        expect { call }.not_to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end

    context 'without the user in the params' do
      let(:params) { { email: 'foo@bar.com' } }

      it { expect(call.success?).to be true }
      it { expect(call.data[:email]).to eq(params[:email]) }
      it { expect(call.data[:user]).to be_instance_of(User) }

      it 'create a new user' do
        expect { call }.to change(User, :count).by(1)
      end

      it 'enqueue a registration confirmation email' do
        expect { call }.to have_enqueued_job(
          ActionMailer::MailDeliveryJob
        ).with('UserMailer', 'registration_confirmation', any_args)
      end
    end
  end
end
