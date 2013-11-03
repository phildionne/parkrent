FactoryGirl.define do
  factory :rent do
    parking

    price { [50, 100].sample }
  end

  factory :invalid_rent, parent: :rent do
    price       nil
  end
end
