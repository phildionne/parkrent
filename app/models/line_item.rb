class LineItem < ActiveRecord::Base
  belongs_to :order

  validates :order, :quantity, presence: true
  validates_with LineItemValidator
end
