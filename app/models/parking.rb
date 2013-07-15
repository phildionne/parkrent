class Parking < ActiveRecord::Base
  belongs_to :user
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :rents

  validates :user, :location, presence: true
  validates_with RentValidator
end
