FactoryGirl.define do
  factory :line_item do
    quantity [1,2].sample
  end

  factory :invalid_line_item, parent: :line_item do
    quantity 0
  end
end
