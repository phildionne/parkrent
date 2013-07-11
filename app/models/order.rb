class Order < ActiveRecord::Base
  belongs_to :rent
  has_one :payment, dependent: :destroy

  validates :rent, presence: true
  validates_with OrderValidator
end
