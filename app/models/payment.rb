class Payment < ActiveRecord::Base
  belongs_to :order

  validates :order, :amount, presence: true
  validates :amount, numericality: true
end
