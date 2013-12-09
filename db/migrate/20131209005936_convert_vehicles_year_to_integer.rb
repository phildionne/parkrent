class ConvertVehiclesYearToInteger < ActiveRecord::Migration
  def change
    change_column(:vehicles, :year, "integer USING cast(to_char(year, 'YYYY') as integer)", limit: 4)
  end
end
