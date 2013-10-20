class MovePublishedFromRentsToParkings < ActiveRecord::Migration
  def change
    remove_column(:rents, :published, :boolean)
    add_column(:parkings, :published, :boolean)
  end
end
