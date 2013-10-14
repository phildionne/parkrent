class User < ActiveRecord::Base
  include Contactable

  acts_as_paranoid

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :orders,   dependent: :destroy
  has_many :parkings, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :rents,    through: :parkings
  has_many :sales,    through: :rents, source: :orders
end
