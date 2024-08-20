FactoryBot.define do
  factory :survey do
    sequence(:title) { |n| "Survey #{n}" }
    user

    trait :closed do
      status { 'closed' }
    end

    trait :open do
      status { 'open' }
    end
  end
end
