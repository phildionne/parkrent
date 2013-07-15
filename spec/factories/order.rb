FactoryGirl.define do
  factory :order do
    user
    rent
  end

  factory :order_with_payment, parent: :order do
    after(:create) do |order|
      FactoryGirl.create(:payment, order: order)
    end
  end

  factory :invalid_order, parent: :order do
    user nil
    rent nil
  end
end
