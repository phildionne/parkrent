FactoryGirl.define do
  factory :vehicle do
    user

    license_plate { ['A00 ABC', 'ABC 000', '000H000', 'CC 000', 'CD 000'].sample }
  end

  factory :invalid_vehicle, parent: :vehicle do
    license_plate nil
  end
end



