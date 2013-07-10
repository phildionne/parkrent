class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :location

      t.timestamps
    end
  end
end
