class ModifyRentScheduleAssociation < ActiveRecord::Migration
  def change
    add_column(:schedules, :rent_id, :integer)
    remove_column(:rents, :schedule_id)
  end
end
