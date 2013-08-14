class Vehicle < ActiveRecord::Base
  validates :user, :license_plate, presence: true
  validates :license_plate, license_plate: true

  belongs_to :user
end
