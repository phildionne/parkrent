class Rent < ActiveRecord::Base
  belongs_to :parking

  validates :parking, :price, :beginning, :termination, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates_with RentValidator
end
