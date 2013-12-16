class Schedule < ActiveRecord::Base

  belongs_to :rent, inverse_of: :schedule
  has_one :parking, through: :rent

  validates :start_time, :end_time, :daily_start_hour, :daily_end_hour, presence: true
  validates :daily_start_hour, :daily_end_hour, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }
  validates_with ScheduleValidator
end
