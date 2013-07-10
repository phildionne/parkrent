class Rent < ActiveRecord::Base
  validates :parking, :price, :beginning, :termination, presence: true
  validates :price, numericality: true

  belongs_to :parking
end
