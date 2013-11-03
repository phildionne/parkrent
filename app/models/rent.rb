class Rent < ActiveRecord::Base
  include Authority::Abilities

  delegate :start_date, :end_date, to: :schedule

  serialize :schedule, Hash

  belongs_to :parking
  has_one :user, through: :parking
  has_many :orders

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
  validates :parking, :price, :schedule, presence: true
  validates_with RentValidator

  def title
    "#{price.format} - #{schedule.to_s}"
  end

  # @return [IceCube::Schedule]
  def schedule
    IceCube::Schedule.from_hash(read_attribute(:schedule))
  end

  # @param new_schedule [IceCube::Schedule]
  # @return [IceCube::Schedule]
  def schedule=(new_schedule)
    schedule_will_change! unless new_schedule == schedule
    write_attribute(:schedule, new_schedule.to_hash)
  end

  end
end
