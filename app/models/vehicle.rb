class Vehicle < ActiveRecord::Base
  include Authority::Abilities

  validates :user, :license_plate, presence: true
  validates :year, format: { with: /\A\d{4}\z/, allow_blank: true }
  validates :license_plate, license_plate: true

  belongs_to :user
  has_many :orders, through: :user
end
