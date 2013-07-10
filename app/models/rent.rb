class Rent < ActiveRecord::Base
  validates :price, :beginning, :termination, presence: true
  validates :price, numericality: true
end
