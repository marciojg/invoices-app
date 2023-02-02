# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_secure_password(:token) }
  it { is_expected.to have_secure_password(:renew_token) }
  it { is_expected.to have_secure_password(:confirm_token) }

  describe 'email validations' do
    it { is_expected.to validate_presence_of(:email) }

    context 'with email uniqueness' do
      subject { create(:user) }

      it { is_expected.to validate_uniqueness_of(:email) }
    end

    context 'with invalid email' do
      subject(:user) { build(:user, email: 'foobar.com') }

      it do
        user.valid?

        expect(user.errors.key?(:email)).to be true
      end
    end
  end
end
