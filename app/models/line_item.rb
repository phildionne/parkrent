class LineItem < ActiveRecord::Base
  validates :quantity, presence: true
  validates_with LineItemValidator
end
