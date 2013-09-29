class User < ActiveRecord::Base
  include Contactable

  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :parkings, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :rents, through: :parkings
  has_many :sales, through: :rents, source: :orders

  # #return [ActiveRecord::Relation] Orders made for rents owned by this user
  def rent_orders
  end
end
