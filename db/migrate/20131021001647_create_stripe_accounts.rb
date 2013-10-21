class CreateStripeAccounts < ActiveRecord::Migration
  def change
    create_table :stripe_accounts do |t|
      t.belongs_to :user
      t.string :stripe_user_id
      t.string :publishable_key
      t.string :access_token

      t.timestamps
    end
  end
end
