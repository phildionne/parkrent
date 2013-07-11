class Parking < ActiveRecord::Base
  has_many :rents, dependent: :destroy

  validates :location, presence: true
  validates_with RentValidator
end
