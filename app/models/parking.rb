class Parking < ActiveRecord::Base
  belongs_to :seller, foreign_key: 'user_id'
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :rents

  validates :seller, :location, presence: true
  validates_with RentValidator
end
