class AddUserIdToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :user_id, :integer
  end
end
