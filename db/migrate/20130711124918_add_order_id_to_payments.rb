class AddOrderIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :order_id, :integer
  end
end
