FactoryGirl.define do
  factory :user do
    first_name   'bob'
    last_name    'monet'
    phone_number '+12025550131'
    password     'very-secret-password'
    sequence(:email) { |n| "user#{n}@twilio.com" }
  end
end
