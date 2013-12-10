class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :daily_start_hour
      t.integer :daily_end_hour
      t.boolean :weekend, default: false

      t.timestamps
    end

    change_table :rents do |t|
      t.integer :schedule_id
    end
  end
end
