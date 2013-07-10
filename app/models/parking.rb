class Parking < ActiveRecord::Base
  validates :location, presence: true

  has_many :rents, dependent: :destroy
end
