FactoryGirl.define do
  factory :parking do
    location "Somewhere"
  end

  factory :invalid_parking, parent: :parking do
    location nil
  end
end
