class GuestOrder
  include Associates

  associate :user, only: [:first_name, :last_name, :phone_number, :email,
            :password, :password_confirmation, :confirmation_token]
  associate :vehicle, depends_on: :user
  associate :order, only: :rent_id, depends_on: [:user, :vehicle]
end
