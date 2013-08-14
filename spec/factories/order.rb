FactoryGirl.define do
  factory :order do
    association :user, factory: :user_with_vehicles
    rent
    vehicle { user.vehicles.sample }
  end

  factory :order_with_payment, parent: :order do
    after(:create) do |order|
      FactoryGirl.create(:payment, order: order)
    end
  end

  factory :invalid_order, parent: :order do
    user
    rent nil
    vehicle nil
  end
end
