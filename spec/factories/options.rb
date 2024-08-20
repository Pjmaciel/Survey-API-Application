FactoryBot.define do
  factory :option do
    association :question
    option_text { 'Sample Option' }
  end
end
