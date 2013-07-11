FactoryGirl.define do
  factory :seller, parent: :user, class: Seller do
  end

  factory :seller_with_parkings, parent: :seller do
    ignore do
      parkings_count [0,1,2].sample
    end

    after(:create) do |seller, evaluator|
      FactoryGirl.create_list(:parking, evaluator.parkings_count, seller: seller)
    end
  end

  factory :seller_with_parkings_and_rents, parent: :seller do
    ignore do
      parkings_count [0,1,2].sample
    end

    after(:create) do |seller, evaluator|
      FactoryGirl.create_list(:parking_with_rents, evaluator.parkings_count, seller: seller)
    end
  end

  factory :invalid_seller, parent: :invalid_user do
  end
end
