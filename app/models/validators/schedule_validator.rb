class ScheduleValidator < ActiveModel::Validator

  # @param record [Rent]
  def validate(record)
    validate_end_date_is_after_start_date(record) if record.end_time.present?
    validate_start_date_is_after_today(record) unless record.persisted?
  end


  private

  def validate_end_date_is_after_start_date(record)
    unless record.end_time > record.start_time
      record.errors.add(:end_time, "end time must be after start time")
    end
  end

  def validate_start_date_is_after_today(record)
    unless record.start_time > Proc.new { Date.yesterday.at_end_of_day }.call
      record.errors.add(:start_time, "start time must be after today")
    end
  end
end
