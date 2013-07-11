class Parking < ActiveRecord::Base
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :rents

  validates :location, presence: true
  validates_with RentValidator
end
