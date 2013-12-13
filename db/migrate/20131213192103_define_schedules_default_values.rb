class DefineSchedulesDefaultValues < ActiveRecord::Migration
  def change
    change_column(:schedules, :daily_start_hour, :integer, default: 9)
    change_column(:schedules, :daily_end_hour, :integer, default: 17)
  end
end
