FactoryGirl.define do
  factory :payment do
    order

    stripe_charge_id { Object.new.hash.to_s }
    amount           { [50, 60, 100].sample }
  end

  factory :invalid_payment, parent: :payment do
    amount 0
  end
end
