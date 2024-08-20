FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { "test_#{SecureRandom.hex(8)}@example.com" }
    password { 'password' }
    role { 'coordinator' }
  end
end