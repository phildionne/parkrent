class ParkingValidator < ActiveModel::Validator

  # @param record [Parking]
  def validate(record)
    # record.errors[:base] = "This record is invalid"
  end
end
