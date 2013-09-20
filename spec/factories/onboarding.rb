FactoryGirl.define do
  factory :onboarding do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    email        { Faker::Internet.email }
    password     { first_name + last_name + phone_number }
    password_confirmation { password }

    price        { [50, 100].sample }
    beginning    { Date.current }
    termination  { beginning + [1, 2, 3].sample.month }

    location     { [Faker::Address.street_name, ", ", Faker::Address.city].join }
  end

  factory :invalid_onboarding, parent: :onboarding do
    first_name   nil
    last_name    nil
    phone_number nil
    email        nil
    password     nil
    password_confirmation nil

    price        nil
    beginning    nil
    termination  nil

    location     nil
  end
end
