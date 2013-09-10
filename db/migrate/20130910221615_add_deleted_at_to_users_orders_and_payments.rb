class AddDeletedAtToUsersOrdersAndPayments < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_column :orders, :deleted_at, :datetime
    add_column :payments, :deleted_at, :datetime
  end
end
