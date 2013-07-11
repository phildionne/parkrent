FactoryGirl.define do
  factory :buyer, parent: :user, class: Buyer do
  end

  factory :invalid_buyer, parent: :invalid_user do
  end
end
