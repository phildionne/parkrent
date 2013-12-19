class Parking < ActiveRecord::Base
  include Authority::Abilities

  acts_as_commentable

  geocoded_by :location

  belongs_to :user
  has_many :rents, dependent: :destroy
  has_many :clients, through: :rents, source: :clients

  scope :published,   -> { where(published: true) }
  scope :unpublished, -> { where(published: false)}

  # accepts_nested_attributes_for :rents, :reject_if => :all_blank, :allow_destroy => true

  validates :user, :location, presence: true
  validates_with ParkingValidator

  after_validation :geocode, if: :location_changed?

  def publish
    update_attribute(:published, true)
  end

  def unpublish
    update_attribute(:published, false)
  end

  def published?
    published
  end
end
