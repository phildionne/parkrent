class Rent < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :parking
  has_one :schedule, dependent: :destroy
  has_one :user, through: :parking
  has_many :orders

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
  validates :parking, :price, presence: true
  validates_with RentValidator
end
