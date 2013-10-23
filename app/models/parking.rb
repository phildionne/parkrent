class Parking < ActiveRecord::Base
  include Authority::Abilities

  geocoded_by :location

  belongs_to :user
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :rents, :reject_if => :all_blank, :allow_destroy => true
  scope :published,   -> { where(published: true) }
  scope :unpublished, -> { where(published: false)}

  validates :user, :location, presence: true
  validates_with RentValidator

  after_validation :geocode, if: :location_changed?

  def publish
    update_attribute(:published, true)
  end

  def unpublish
    update_attribute(:published, false)
  end
end
