FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { "success" }
    created_at { Date.today }
    updated_at { Date.today }
  end

  factory :failed_transaction, parent: :transaction do
    result { "failed" }
  end
end
