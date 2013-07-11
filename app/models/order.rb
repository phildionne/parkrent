class Order < ActiveRecord::Base
  has_many :payments, dependent: :destroy

  validates_with OrderValidator
end
