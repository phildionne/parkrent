FactoryGirl.define do
  factory :order do
  end

  factory :order_with_line_items, parent: :order do
    ignore do
      line_items_count [1,2,3].sample
    end

    after(:create) do |order, evaluator|
      order.line_items << FactoryGirl.create_list(:line_item, evaluator.line_items_count)
    end
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
