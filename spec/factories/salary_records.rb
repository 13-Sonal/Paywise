FactoryBot.define do
  factory :salary_record do
    user
    role { user.role }
    compensation { 85_000 }
    currency { "INR" }
    effective_from { Date.new(2026, 4, 1) }
  end
end
