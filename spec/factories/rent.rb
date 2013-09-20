FactoryGirl.define do
  factory :rent do
    parking

    price       { [50, 100].sample }
    beginning   { Date.current }
    termination { beginning + [1, 2, 3].sample.month }
  end

  factory :invalid_rent, parent: :rent do
    price       nil
    beginning   nil
    termination nil
  end
end
