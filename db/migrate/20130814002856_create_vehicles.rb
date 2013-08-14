class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.belongs_to :user
    end
  end
end
