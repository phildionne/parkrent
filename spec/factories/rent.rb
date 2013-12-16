FactoryGirl.define do
  factory :rent do
    parking

    price { [50, 100].sample }

    before(:create) do |rent|
      rent.schedule = create(:schedule, rent: rent)
    end

    after(:build) do |rent|
      rent.schedule = build(:schedule)
    end
  end

  factory :invalid_rent, parent: :rent do
    price -10
  end
end
