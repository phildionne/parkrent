class Onboarding
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_writer :user, :parking, :rent

  delegate :first_name, :last_name, :phone_number, :email,
           :password, :password_confirmation, :confirmation_token,
           :first_name=, :last_name=, :phone_number=, :email=,
           :password=, :password_confirmation=, :confirmation_token=, to: :user
  delegate :location, :location=, to: :parking
  delegate :beginning, :termination, :price, :beginning=, :termination=, :price=, to: :rent

  validates :first_name, :last_name, :phone_number, :email, :location,
            :beginning, :termination, :price, :password, :password_confirmation, presence: true

  # param attributes [Hash]
  def initialize(attributes = {})
    attributes.each do |attr, value|
      self.public_send("#{attr}=", value)
    end
  end

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

end
