class LineItemValidator < ActiveModel::Validator

  # @param record [LineItem]
  def validate(record)
    # record.errors[:base] = "This record is invalid"
  end
end
