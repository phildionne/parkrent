FactoryGirl.define do
  factory :user do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }

    email        { Faker::Internet.email }
    password     { Faker::Lorem.characters(10) }
  end

  factory :user_with_vehicles, parent: :user do
    ignore do
      vehicles_count [1,2].sample
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:vehicle, evaluator.vehicles_count, user: user)
    end
  end

  factory :user_with_parkings, parent: :user do
    ignore do
      parkings_count [1,2].sample
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:parking, evaluator.parkings_count, user: user)
    end
  end

  factory :user_with_parkings_and_rents, parent: :user do
    ignore do
      parkings_count [1,2].sample
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:parking_with_rents, evaluator.parkings_count, user: user)
    end
  end

  factory :invalid_user, parent: :user do
    first_name   nil
    last_name    nil
    phone_number nil

    email        nil
    password     nil
  end
end
