class Onboarding
  include Associates

  associate :user, only: [:first_name, :last_name, :phone_number, :email,
            :password, :password_confirmation, :confirmation_token]
  associate :parking, depends_on: :user
  associate :rent, only: [:price], depends_on: :parking
  associate :schedule, depends_on: :rent

  # @return [Boolean] Wether the Onboarding is only missing the user's password & password_confirmation
  def can_assign_credentials?
    valid?
    [
      [:password, :password_confirmation],
      [:password],
      [:password_confirmation]
    ].any? { |missing_attributes| missing_attributes == errors.keys }
  end
end
