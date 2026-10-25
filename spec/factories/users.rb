FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Employee #{n}" }
    sequence(:email) { |n| "employee#{n}@paywise.example" }
    password { "Password@123" }
    blood_group { "O+" }
    country_code { "IN" }
    role

    trait :admin do
      role { association :role, :admin }
    end

    trait :hr_manager do
      role { association :role, :hr_manager }
    end

    trait :hr do
      role { association :role, :hr }
    end
  end
end
