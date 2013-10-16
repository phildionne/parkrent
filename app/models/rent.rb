class Rent < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :parking
  has_one :user, through: :parking
  has_many :orders

  scope :published,   -> { where(published: true) }
  scope :unpublished, -> { where(published: false)}

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
  validates :parking, :price, :beginning, :termination, presence: true
  validates :beginning, date: { before: :termination }
  validates :beginning, date: { after: Proc.new { Date.yesterday.at_end_of_day }}
  validates_with RentValidator

  def title
    "#{price.format} - #{beginning.to_formatted_s(:short)} #{termination.to_formatted_s(:short)}"
  end
end
