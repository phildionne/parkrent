class ScheduleValidator < ActiveModel::Validator

  # @param record [Rent]
  def validate(record)
    validate_end_time_is_after_start_time(record) if record.end_time.present?
    validate_start_time_not_in_past(record) if record.start_time.present? && !record.persisted?
  end


  private

  def validate_end_time_is_after_start_time(record)
    unless record.end_time > record.start_time
      record.errors.add(:end_time, "end time must be after start time")
    end
  end

  def validate_start_time_not_in_past(record)
    unless record.start_time > Proc.new { Date.yesterday.at_end_of_day }.call
      record.errors.add(:start_time, "start time must be after today")
    end
  end
end
