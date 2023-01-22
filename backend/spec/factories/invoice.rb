FactoryBot.define do
  factory :invoice do
    number { rand(10**5) }
    reference_date { Date.current }
    company_data { FFaker::AddressBR.street_address }
    billing_data { FFaker::AddressBR.street_address }
    value_cents { rand(10**4) }
    emails { [FFaker::Internet.email] }
  end
end
