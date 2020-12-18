FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "shipped" }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    updated_at { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
  end
end
