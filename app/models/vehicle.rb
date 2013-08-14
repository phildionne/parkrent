class Vehicle < ActiveRecord::Base
  validates :user, :license_plate, presence: true

  belongs_to :user
end
