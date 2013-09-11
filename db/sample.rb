FactoryGirl.create_list(:user_with_parkings_and_rents, 10)

User.limit(5).each do |user|
  FactoryGirl.create(:vehicle, user: user)
  FactoryGirl.create_list(:order_with_payment, 3, user: user)
end
