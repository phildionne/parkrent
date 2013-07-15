class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :rent
  has_one :payment, dependent: :destroy

  accepts_nested_attributes_for :rent

  validates :user, :rent, presence: true
  validates_with OrderValidator
end
