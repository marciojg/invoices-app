# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:company_data) }
    it { is_expected.to validate_presence_of(:billing_data) }
    it { is_expected.to validate_presence_of(:emails) }
    it { is_expected.to validate_numericality_of(:number).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:value_cents).is_greater_than(0) }

    context 'with the uniqueness of the number' do
      subject { create(:invoice) }

      it { is_expected.to validate_uniqueness_of(:number) }
    end

    context 'with invalid emails' do
      subject(:invoice) { build(:invoice, emails: ['foobar.com']) }

      it do
        invoice.valid?

        expect(invoice.errors.key?(:emails)).to be true
      end
    end

    context 'with invalid reference_date' do
      context 'with invalid date' do
        subject(:invoice) { build(:invoice, reference_date: '2020-20-20') }

        it do
          invoice.valid?

          expect(invoice.errors.key?(:reference_date)).to be true
        end
      end

      context 'without value' do
        subject(:invoice) { build(:invoice, reference_date: nil) }

        it do
          invoice.valid?

          expect(invoice.errors.key?(:reference_date)).to be true
        end
      end
    end
  end
end
