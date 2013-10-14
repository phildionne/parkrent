class AddPublishedToRents < ActiveRecord::Migration
  def change
    add_column(:rents, :published, :boolean)
  end
end
