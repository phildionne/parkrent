class GuestOrder
  include Associates

  associate :first_name, :last_name, :phone_number, :email,
            :password, :password_confirmation, :confirmation_token, to: :user
  associate :license_plate, :model, :year, to: :vehicle, depend_on: :user
  associate :price, :rent, :rent_id,       to: :order,   depend_on: [:user, :vehicle]
end
