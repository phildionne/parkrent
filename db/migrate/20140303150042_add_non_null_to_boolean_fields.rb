class AddNonNullToBooleanFields < ActiveRecord::Migration
  def change
    change_column_null :parkings, :published, false
    change_column_null :schedules, :weekend, false
  end
end
