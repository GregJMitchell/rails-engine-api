FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.within(range: 1..30) }
    unit_price { Faker::Commerce.price }
    created_at { Date.today }
    updated_at { Date.today }
  end
end
