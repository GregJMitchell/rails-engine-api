FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    created_at { Date.today }
    updated_at { Date.today }
  end
end