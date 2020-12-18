FactoryBot.define do
  factory :customer do
    name { Faker::Name.first_name }
    created_at { Date.today }
    updated_at { Date.today }
  end
end
