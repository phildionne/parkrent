class Onboarding
  include Associates

  associate :user, only: [:first_name, :last_name, :phone_number, :email,
            :password, :password_confirmation, :confirmation_token]
  associate :parking,                                        depends_on: :user
  associate :rent, only: [:beginning, :termination, :price], depends_on: :parking

  # @return [Boolean] Wether the Onboarding is only missing the user's password & password_confirmation
  def can_assign_credential?
    valid?
    errors.keys == [:password, :password_confirmation]
  end
end
