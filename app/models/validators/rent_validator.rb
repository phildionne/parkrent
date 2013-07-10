class RentValidator < ActiveModel::Validator

  # @param record [Rent]
  def validate(record)
    # record.errors[:base] = "This record is invalid"
  end
end
