FactoryGirl.define do
  factory :order do
    association :rent, factory: :rent
    association :user, factory: :user_with_vehicles
    vehicle nil

    before(:create) do |order|
      order.vehicle = order.user.vehicles.sample
    end
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
