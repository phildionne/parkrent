class Order < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :rent
  belongs_to :vehicle
  has_one :payment, dependent: :destroy

  validates :user, :rent, :vehicle, presence: true
  validates_with OrderValidator
end
