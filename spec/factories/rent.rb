FactoryGirl.define do
  factory :rent do
    parking

    price       { [50, 100].sample }
    beginning   { Date.today }
    termination { Date.today + 1.day }
  end

  factory :invalid_rent, parent: :rent do
    price       nil
    beginning   nil
    termination nil
  end
end
