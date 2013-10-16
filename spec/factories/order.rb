FactoryGirl.define do
  factory :order do
    rent    { create(:rent) }
    user    { create(:user) }
    vehicle { create(:vehicle, user: user) }
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
