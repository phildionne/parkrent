class RentValidator < ActiveModel::Validator

  # @param record [Rent]
  def validate(record)
    validate_end_date_is_after_start_date(record) if record.end_date.present?
    validate_start_date_is_after_today(record) if record.new_record?
  end


  private

  def validate_end_date_is_after_start_date(record)
    unless record.end_date > record.start_date
      record.errors.add(:schedule, "end date must be after start date")
    end
  end

  def validate_start_date_is_after_today(record)
    unless record.start_date > Proc.new { Date.yesterday.at_end_of_day }.call
      record.errors.add(:schedule, "start date must be after today")
    end
  end
end
