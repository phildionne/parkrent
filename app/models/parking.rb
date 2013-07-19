class Parking < ActiveRecord::Base

  acts_as_gmappable

  geocoded_by :location

  belongs_to :user
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :rents

  validates :user, :location, presence: true
  validates_with RentValidator

  after_validation :geocode, if: :location_changed?

  # @return [String]
  def gmaps4rails_address
    [latitude, longitude].join
  end
end
