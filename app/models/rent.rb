class Rent < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :parking
  has_one :schedule, validate: true, dependent: :destroy
  has_one :user, through: :parking
  has_many :orders

  accepts_nested_attributes_for :schedule

  monetize :price_cents, numericality: { greater_than: 0, less_than_or_equal_to: 10000 }
  validates :parking, :price, :schedule, presence: true
  validates_with RentValidator
end
