class Payment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :order

  validates :order, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
