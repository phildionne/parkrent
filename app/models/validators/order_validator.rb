class OrderValidator < ActiveModel::Validator

  # @param record [Order]
  def validate(record)
    # record.errors[:base] = "This record is invalid"
  end
end
