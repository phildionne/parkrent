class Schedule
  include ActiveModel::Model
  include Virtus.model

  attribute :daily_start_hour, Integer, default: 7
  attribute :daily_end_hour,   Integer, default: 17
  attribute :weekend,          Boolean, default: false

  validates_with ScheduleValidator
end
