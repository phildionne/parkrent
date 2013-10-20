class Payment < ActiveRecord::Base
  include Authority::Abilities

  acts_as_paranoid

  belongs_to :order
  has_one :user, through: :order

  validates :order, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
