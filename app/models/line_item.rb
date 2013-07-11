class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :rent

  validates :order, :rent, :quantity, presence: true
  validates_with LineItemValidator
end
