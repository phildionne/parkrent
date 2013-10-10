class GuestOrder
  include Associates

  associate :user, only: [:first_name, :last_name, :phone_number, :email,
            :password, :password_confirmation, :confirmation_token]
  associate :vehicle, depends_on: :user
  associate :rent

  associate :order, depend_on: [:user, :vehicle, :rent]
end
