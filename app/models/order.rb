class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  validates_with OrderValidator
end
