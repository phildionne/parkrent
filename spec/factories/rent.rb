FactoryGirl.define do
  factory :rent do
    parking

    price       { [50, 100].sample }
    beginning   { Date.tomorrow }
    termination { beginning + [1, 40, 120].sample.day }
  end

  factory :invalid_rent, parent: :rent do
    price       nil
    beginning   nil
    termination nil
  end
end
