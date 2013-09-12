class AddModelAndYearToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :model, :string
    add_column :vehicles, :year, :date
  end
end
