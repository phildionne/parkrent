class AddParkingIdToRents < ActiveRecord::Migration
  def change
    add_column :rents, :parking_id, :integer
  end
end
