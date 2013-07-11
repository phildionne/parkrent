class Seller < User
  has_many :parkings, foreign_key: 'user_id'
end
