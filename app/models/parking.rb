class Parking < ActiveRecord::Base

  geocoded_by :location

  belongs_to :user
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :rents, :reject_if => :all_blank, :allow_destroy => true

  validates :user, :location, presence: true
  validates_with RentValidator

  after_validation :geocode, if: :location_changed?
end
