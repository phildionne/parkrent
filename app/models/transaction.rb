class Transaction < ActiveRecord::Base
  validates :rent, presence: true

end
