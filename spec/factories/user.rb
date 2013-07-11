FactoryGirl.define do
  factory :user do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    email        { Faker::Internet.email }
  end

  factory :invalid_user, parent: :user do
    first_name   nil
    last_name    nil
    phone_number nil
    email        nil
  end
end
