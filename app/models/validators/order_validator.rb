class OrderValidator < ActiveModel::Validator

  # @param record [Order]
  def validate(record)
    validate_vehicle_belongs_to_user(record)
  end


  private

  def validate_vehicle_belongs_to_user(record)
    unless record.user && record.vehicle && record.user == record.vehicle.try(:user)
      record.errors[:vehicle] = "must belong to the user."
    end
  end
end
