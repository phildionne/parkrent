FactoryGirl.define do
  factory :vehicle do
    user

    license_plate { [Faker::Lorem.characters(3), Faker::Number.number(3)].flatten.shuffle.join }
  end

  factory :invalid_vehicle, parent: :vehicle do
    license_plate nil
  end
end



