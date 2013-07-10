class Parking < ActiveRecord::Base
  validates :location, presence: true
end
