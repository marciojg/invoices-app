# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer do
  let(:user) { create(:user, email: 'foo@bar.com') }

  describe '#registration_confirmation' do
    let(:mail) { described_class.with(user:, token: 'foo', confirm_token: 'bar').registration_confirmation }

    context 'with headers renders' do
      it { expect(mail.subject).to eq('Registration Confirmation') }
      it { expect(mail.to).to eq(['foo@bar.com']) }
      it { expect(mail.from).to eq(['noreply@example.com']) }
    end

    context 'with body renders' do
      it { expect(mail.body.encoded).to match('token: foo') }
      it { expect(mail.body.encoded).to match('confirm_token=bar') }
      it { expect(mail.body.encoded).to match('email=foo%40bar.com') }
    end
  end

  describe '#renew_registration' do
    let(:mail) { described_class.with(user:, renew_token: 'foo', confirm_token: 'bar').renew_registration }

    context 'with headers renders' do
      it { expect(mail.subject).to eq('Renew your registration') }
      it { expect(mail.to).to eq(['foo@bar.com']) }
      it { expect(mail.from).to eq(['noreply@example.com']) }
    end

    context 'with body renders' do
      it { expect(mail.body.encoded).to match('token: foo') }
      it { expect(mail.body.encoded).to match('click the URL below.') }
      it { expect(mail.body.encoded).to match('confirm_token=bar') }
      it { expect(mail.body.encoded).to match('email=foo%40bar.com') }
      it { expect(mail.body.encoded).to match('renew=true') }
    end
  end
end
