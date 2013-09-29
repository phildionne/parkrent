class Onboarding
  include Associates

  associate :first_name, :last_name, :phone_number, :email,
            :password, :password_confirmation, :confirmation_token, to: :user
  associate :location, to: :parking, depend_on: :user
  associate :beginning, :termination, :price, to: :rent, depend_on: :parking

  # @return [Boolean] Wether the Onboarding is only missing the user's password & password_confirmation
  def can_assign_credential?
    valid?
    errors.keys == [:password, :password_confirmation]
  end
end
