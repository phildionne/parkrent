FactoryGirl.define do
  factory :order do
    user

    before(:create) do |order|
      order.rent ||= create(:rent)
      order.vehicle ||= create(:vehicle, user: order.user)
    end

    after(:build) do |order|
      order.rent ||= build(:rent)
      order.vehicle ||= build(:vehicle, user: order.user)
    end
  end

  factory :order_with_payment, parent: :order do
    after(:create) do |order|
      FactoryGirl.create(:payment, order: order)
    end
  end

  factory :invalid_order, parent: :order do
    user    nil
    rent    nil
    vehicle nil
  end
end
