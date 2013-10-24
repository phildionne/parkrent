class User < ActiveRecord::Base
  include Contactable

  include Authority::UserAbilities

  acts_as_paranoid

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :orders,   dependent: :destroy
  has_many :parkings, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :rents,    through: :parkings
  has_many :sales,    through: :rents, source: :orders
  has_one  :stripe_account

  # @note See ApplicationController #current_user
  attr_accessor :authenticated
  def authenticated?
    authenticated
  end
end
