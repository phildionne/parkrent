FactoryGirl.define do
  factory :rent do
    parking

    price { [50, 100].sample }
  end

  factory :rent_with_schedule, parent: :rent do
    after(:create) do |rent|
      rent.schedule = create(:schedule, rent: rent)
    end
  end

  factory :invalid_rent, parent: :rent do
    price nil
  end
end
