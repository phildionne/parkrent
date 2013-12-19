class AddCommentsCountToParkings < ActiveRecord::Migration
  def change
    add_column(:parkings, :comments_count, :integer, default: 0)
  end
end
