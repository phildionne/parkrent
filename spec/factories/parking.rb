FactoryGirl.define do
  factory :parking do
    user

    location  { [Faker::Address.street_name, ", ", Faker::Address.city].join }
    itinerary { Faker::Lorem.paragraph(2) }

    trait :published do
      published true
    end

    trait :unpublished do
      published false
    end
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
