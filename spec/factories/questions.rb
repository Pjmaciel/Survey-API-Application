FactoryBot.define do
  factory :question do
    survey { nil }
    question_text { "MyString" }
    question_type { "MyString" }
  end
end
