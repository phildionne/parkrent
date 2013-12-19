FactoryGirl.define do
  factory :comment do
    comment { Faker::Lorem.paragraph }

    association :commentable, factory: :parking
    association :commenter, factory: :user
  end

  factory :invalid_comment, parent: :comment do
    comment nil
  end
end
