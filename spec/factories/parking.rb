FactoryGirl.define do
  factory :parking do
    location "Somewhere"
  end

  factory :parking_with_rents, parent: :parking do
    ignore do
      rents_count [1,2].sample
    end

    after(:create) do |parking, evaluator|
      FactoryGirl.create_list(:rent, evaluator.rents_count, parking: parking)
    end
  end

  factory :invalid_parking, parent: :parking do
    location nil
  end
end
