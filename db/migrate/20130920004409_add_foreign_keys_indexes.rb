class AddForeignKeysIndexes < ActiveRecord::Migration
  def change
    add_index :orders, :user_id
    add_index :orders, :rent_id
    add_index :orders, :vehicle_id

    add_index :parkings, :user_id

    add_index :payments, :order_id

    add_index :rents, :parking_id

    add_index :vehicles, :user_id
  end
end
