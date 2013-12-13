class Schedule < ActiveRecord::Base

  belongs_to :rent
  has_one :parking, through: :rent

  validates :start_time, :end_time, :daily_start_hour, :daily_end_hour, :rent, presence: true
  validates_with ScheduleValidator
end
