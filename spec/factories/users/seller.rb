FactoryGirl.define do
  factory :seller, parent: :user, class: Seller do
  end

  factory :invalid_seller, parent: :seller do
  end
end
