class AddVehicleIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :vehicle_id, :integer
  end
end
