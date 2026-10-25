FactoryBot.define do
  factory :role do
    name { "Software Engineer" }

    trait :admin do
      name { Role::ADMIN }
    end

    trait :hr_manager do
      name { Role::HR_MANAGER }
    end

    trait :hr do
      name { Role::HR }
    end
  end
end
