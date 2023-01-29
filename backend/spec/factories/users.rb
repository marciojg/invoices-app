# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    token { SecureRandom.hex }
    confirm_token { SecureRandom.hex }
  end
end
