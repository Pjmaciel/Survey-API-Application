FactoryBot.define do
  factory :response do
    question
    user
    response_text { "Option 1" }
  end
end
