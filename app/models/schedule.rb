class Schedule < ActiveRecord::Base

  attribute :daily_start_hour, Integer, default: 7
  attribute :daily_end_hour,   Integer, default: 17
  attribute :weekend,          Boolean, default: false
  belongs_to :rent
  has_one :parking, through: :rent

  validates :start_time, :end_time, :weekend, :rent, presence: true
  validates_with ScheduleValidator
end
