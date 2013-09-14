class Checkout
  include ActiveModel::Model

  delegate :first_name, :last_name, :phone_number, :email,
           :password, :password_confirmation, :confirmation_token,
           :first_name=, :last_name=, :phone_number=, :email=,
           :password=, :password_confirmation=, :confirmation_token=, to: :user
  delegate :license_plate, :license_plate=, :model, :model=, :year, :year=, to: :vehicle
  delegate :rent, :rent=, :rent_id, :rent_id=, to: :order

  validates :first_name, :last_name, :phone_number, :email, :password, :password_confirmation,
            :license_plate, :rent_id, presence: true

  def order
    @order ||= Order.new
  end

  def user
    @user ||= User.new
  end

  def vehicle
    @vehicle ||= Vehicle.new
  end

  # Creates a new User with an associated Vehicle and Order
  #
  # @return [Boolean] Success
  def process
    return false unless valid?

    ActiveRecord::Base.transaction do
      begin
        @user.save!
        @vehicle.user = @user
        @vehicle.save!
        @order.user = @user
        @order.vehicle = @vehicle
        @order.save!
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

    [:order, :user, :vehicle].each do |model|
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
end
