FactoryGirl.define do
  factory :payment do
    order

    amount { [50, 60, 100].sample }
  end

  factory :invalid_payment, parent: :payment do
    amount 0
  end
end
