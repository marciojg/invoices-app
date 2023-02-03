# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth' do
  let(:headers) do
    {
      'ACCEPT' => 'application/json',
      'CONTENT_TYPE' => 'application/json'
    }
  end

  let(:data) { JSON.parse(response.body)['data'] }

  describe 'POST /signup' do
    subject(:signup) { post auth_signup_url, headers:, params: }

    let(:params) { { user: user_hash }.to_json }

    context 'with valid parameters' do
      let(:user_hash) { { email: 'foo@bar.com' } }

      context 'when is a new email' do
        it 'creates a new User' do
          expect { signup }.to change(User, :count).by(1)
        end

        it 'enqueue a registration confirmation email' do
          expect { signup }.to have_enqueued_job(
            ActionMailer::MailDeliveryJob
          ).with('UserMailer', 'registration_confirmation', any_args)
        end
      end

      context 'when is not a new email' do
        before { create(:user, email: 'foo@bar.com') }

        it 'renew token of user' do
          signup

          expect(User.last.email_confirmed).to be_falsey
        end

        it 'enqueue a renew registration email' do
          expect { signup }.to have_enqueued_job(
            ActionMailer::MailDeliveryJob
          ).with('UserMailer', 'renew_registration', any_args)
        end
      end

      context 'with success response' do
        before { signup }

        it { expect(response).to have_http_status :ok }
        it { expect(data.dig('user', 'email')).to eq(user_hash[:email]) }
      end
    end

    context 'with invalid parameters' do
      let(:user_hash) { { foo: 'foo@bar.com' } }

      it 'does not create a new User' do
        expect { signup }.not_to change(Invoice, :count)
      end

      it 'does not enqueue a registration confirmation email' do
        expect { signup }.not_to have_enqueued_job(
          ActionMailer::MailDeliveryJob
        ).with('UserMailer', 'registration_confirmation', any_args)
      end

      it 'does not enqueue a renew registration email' do
        expect { signup }.not_to have_enqueued_job(
          ActionMailer::MailDeliveryJob
        ).with('UserMailer', 'renew_registration', any_args)
      end

      context 'with errors response' do
        before { signup }

        it { expect(response).to have_http_status :unprocessable_entity }
        it { expect(data['user']).to be_nil }
      end
    end
  end

  describe 'POST /logout' do
    subject(:logout) { post auth_logout_url, headers:, params: }

    let(:params) { {}.to_json }

    context 'with success response' do
      before { logout }

      it { expect(Current.user).to be_nil }
      it { expect(response).to have_http_status :ok }
    end
  end

  describe 'GET /confirm_email' do
    subject(:confirm_email) { get auth_confirm_email_url, headers:, params: }

    let(:params) { { email: 'foo@bar.com', confirm_token: 'foo' } }

    context 'with success response' do
      before do
        create(:user, **params)
        confirm_email
      end

      it { expect(response).to have_http_status :ok }
      it { expect(data['confirm_email']).to be_truthy }
    end

    context 'with errors response' do
      before { confirm_email }

      it { expect(response).to have_http_status :bad_request }
      it { expect(data['confirm_email']).to be_nil }
    end
  end
end
