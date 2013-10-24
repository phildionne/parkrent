class StripeAccount < ActiveRecord::Base
  belongs_to :user
  validates :access_token, :stripe_user_id, :publishable_key, presence: true
end
