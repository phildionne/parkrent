class Buyer < User
  has_many :orders, dependent: :destroy
end
