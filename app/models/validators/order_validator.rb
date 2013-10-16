class OrderValidator < ActiveModel::Validator

  # @param record [Order]
  def validate(record)
    validate_vehicle_belongs_to_user(record)
    validate_rent_doesnt_belongs_to_user(record)
  end


  private

  def validate_rent_doesnt_belongs_to_user(record)
    if record.user && record.rent
      if record.user == record.rent.user
        record.errors[:rent] = "can't belong to the user"
      end
    end
  end

  def validate_vehicle_belongs_to_user(record)
    if record.user && record.vehicle
      unless record.user == record.vehicle.user
        record.errors[:vehicle] = "must belong to the user"
      end
    end
  end
end
