class Payment < ActiveRecord::Base
  validates :order, :amount, presence: true
  validates :amount, numericality: true
end
