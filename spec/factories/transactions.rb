FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { "success" }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    updated_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
  end

  factory :failed_transaction, parent: :transaction do
    result { "failed" }
  end
end
