# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Current do
  describe '.attributes' do
    context 'when has a getter and a setter' do
      it { expect(described_class).to respond_to(:user, :user=) }
    end
  end
end
