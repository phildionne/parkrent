FactoryGirl.define do
  factory :stripe_account do
    user

    stripe_user_id
    publishable_key
    access_token
  end

  factory :invalid_stripe_account, parent: :stripe_account do
    stripe_user_id  nil
    publishable_key nil
    access_token    nil
  end
end
