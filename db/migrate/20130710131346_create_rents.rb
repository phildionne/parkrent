class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.decimal :price
      t.datetime :beginning
      t.datetime :termination

      t.timestamps
    end
  end
end
