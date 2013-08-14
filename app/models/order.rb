class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :rent
  belongs_to :vehicle
  has_one :payment, dependent: :destroy

  validates :user, :rent, :vehicle, presence: true
  validates_with OrderValidator
end
