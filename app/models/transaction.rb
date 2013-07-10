class Transaction < ActiveRecord::Base
  validates :rent, presence: true

  belongs_to :rent
end
