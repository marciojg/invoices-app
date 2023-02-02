# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer do
  describe '#registration_confirmation' do
    let(:user) { create(:user, email: 'foo@bar.com') }
    let(:mail) { described_class.with(user:, token: 'foo').registration_confirmation }

    context 'with headers renders' do
      it { expect(mail.subject).to eq('Registration Confirmation') }
      it { expect(mail.to).to eq(['foo@bar.com']) }
      it { expect(mail.from).to eq(['noreply@example.com']) }
    end

    context 'with body renders' do
      it { expect(mail.body.encoded).to match('token: foo') }
      it { expect(mail.body.encoded).to match('click the URL below.') }
    end
  end
end
