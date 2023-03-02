FactoryBot.define do
  factory :order_address do
    postcode {'123-4567'}
    prefecture_id { Faker::Number.between(from: 2, to: 47) }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.between(from: 0000000000, to: 99999999999) }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
