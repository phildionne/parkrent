FactoryGirl.define do
  factory :guest_order do
    rent

    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    email        { Faker::Internet.email }
    password     { Faker::Lorem.characters(10) }
    password_confirmation { password }

    license_plate { ['A00 ABC', 'ABC 000', '000H000', 'CC 000', 'CD 000'].sample }
  end

  factory :invalid_guest_order, parent: :guest_order do
    first_name   nil
    last_name    nil
    phone_number nil
    email        nil
    password     nil
    password_confirmation nil

    license_plate nil
  end
end
