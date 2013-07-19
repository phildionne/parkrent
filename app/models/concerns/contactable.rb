require 'active_support/concern'

module Contactable
  extend ActiveSupport::Concern

  included do
    validates :first_name, :last_name, :phone_number, :email, presence: true
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
