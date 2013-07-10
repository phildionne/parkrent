class Parking < ActiveRecord::Base
  validates :location, presence: true
  validates_with RentValidator

  has_many :rents, dependent: :destroy
end
