FactoryGirl.define do
  factory :order do
  end

  factory :order_with_payments, parent: :order do
    ignore do
      payments_count [1,2].sample
    end

    after(:create) do |order, evaluator|
      order.payments << FactoryGirl.create_list(:payment, evaluator.payments_count)
    end
  end

  factory :invalid_order, parent: :order do
  end
end
