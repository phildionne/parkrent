FactoryGirl.define do
  factory :order do
  end

  factory :invalid_order, parent: :order do
  end
end
