class Order < ActiveRecord::Base
  belongs_to :buyer, foreign_key: 'user_id'
  belongs_to :rent
  has_one :payment, dependent: :destroy

  accepts_nested_attributes_for :rent

  validates :buyer, :rent, presence: true
  validates_with OrderValidator
end
