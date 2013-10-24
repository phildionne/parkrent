class AddScheduleToRents < ActiveRecord::Migration
  def change
    add_column(:rents, :schedule, :text)
  end
end
