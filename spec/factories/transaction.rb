FactoryGirl.define do
  factory :transaction do
    rent
  end

  factory :invalid_transaction, parent: :transaction do
    rent nil
  end
end
