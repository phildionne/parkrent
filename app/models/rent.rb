class Rent < ActiveRecord::Base
  include Authority::Abilities

  serialize :schedule, Hash

  belongs_to :parking
  has_one :user, through: :parking
  has_many :orders

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
  validates :parking, :price, :beginning, :termination, :schedule, presence: true
  validates :beginning, date: { before: :termination }
  validates :beginning, date: { after: Proc.new { Date.yesterday.at_end_of_day }}, if: :new_record?
  validates_with RentValidator

  def title
    "#{price.format} - #{beginning.to_formatted_s(:short)} #{termination.to_formatted_s(:short)}"
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
