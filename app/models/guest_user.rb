class GuestUser
  include ActiveModel::Model

  # Associations
  def orders
    Order.none
  end

  def parkings
    Parking.none
  end

  def vehicles
    Vehicle.none
  end

  def rents
    Rent.none
  end

  def sales
    Order.none
  end

  # Attributes
  def first_name
    "Guest"
  end

  def last_name
    ""
  end

  def phone_number
    "none"
  end

  def email
    "none"
  end

  def full_name
    first_name
  end

  def authenticated?
    false
  end

  def persisted?
    false
  end
end
