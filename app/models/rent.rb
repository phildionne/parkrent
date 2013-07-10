class Rent < ActiveRecord::Base
  validates :parking, :price, :beginning, :termination, presence: true
  validates :price, numericality: true
  validates_with RentValidator

  belongs_to :parking
  has_many :transactions
end
