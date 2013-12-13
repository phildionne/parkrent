FactoryGirl.define do
  factory :vehicle do
    user

    license_plate { ['A00 ABC', 'ABC 000', '000H000', 'CC 000', 'CD 000'].sample }
    year          { (1995..2013).to_a.sample }
    model         { ['Black Maybach', 'Range Rover', 'Audi A8', 'Volvo'].sample }
  end

  factory :invalid_vehicle, parent: :vehicle do
    license_plate nil
    year          nil
    model         nil
  end
end



