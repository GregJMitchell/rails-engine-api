FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.within(range: 1..30) }
    unit_price { Faker::Commerce.price }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    updated_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
  end
end
