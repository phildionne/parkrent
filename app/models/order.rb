class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :rent
  has_one :payment, dependent: :destroy

  validates :user, :rent, presence: true
  validates_with OrderValidator
end
