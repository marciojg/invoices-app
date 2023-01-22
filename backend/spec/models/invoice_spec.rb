# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:reference_date) }
    it { is_expected.to validate_presence_of(:company_data) }
    it { is_expected.to validate_presence_of(:billing_data) }
    it { is_expected.to validate_presence_of(:emails) }
    it { is_expected.to validate_numericality_of(:number).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:value_cents).is_greater_than(0) }

    context 'with the uniqueness of the number' do
      subject { create(:invoice) }

      it { is_expected.to validate_uniqueness_of(:number) }
    end
  end
end
