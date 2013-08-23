class Onboarding
  include ActiveModel::Model

  delegate :first_name, :last_name, :phone_number, :email,
           :password, :password_confirmation, :confirmation_token,
           :first_name=, :last_name=, :phone_number=, :email=,
           :password=, :password_confirmation=, :confirmation_token=, to: :user
  delegate :location, :location=, to: :parking
  delegate :beginning, :termination, :price, :beginning=, :termination=, :price=, to: :rent

  validates :first_name, :last_name, :phone_number, :email, :location,
            :beginning, :termination, :price, :password, :password_confirmation, presence: true

  def user
    @user ||= User.new
  end

  def parking
    @parking ||= Parking.new
  end

  def rent
    @rent ||= Rent.new
  end

  # Creates a new User with an associated Parking and Rent
  #
  # @return [Boolean] Success
  def register
    return false unless valid?

    ActiveRecord::Base.transaction do
      begin
        @user.save!
        @parking.user = @user
        @parking.save!
        @rent.parking = @parking
        @rent.save!
      rescue ActiveRecord::RecordInvalid
        false
      end
    end
  end

  # Runs all the specified validations and the associated models' validations
  #
  # @return [Boolean]
  def valid?(context = nil)
    super

    [:user, :parking, :rent].each do |model|
      instance = send(model)
      instance.valid?(context)

      instance.attribute_names.each do |attribute|
        if respond_to?(attribute)
          instance.errors[attribute].each do |message|
            errors.add(attribute, message)
          end
        end
      end
    end

    errors.messages.values.each(&:uniq!)
    errors.none?
  end

  # @return [Boolean] Wether the Onboarding is only missing the user's password & password_confirmation
  def can_assign_credential?
    valid?
    errors.keys == [:password, :password_confirmation]
  end
end
