class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates_with OrderValidator
end
