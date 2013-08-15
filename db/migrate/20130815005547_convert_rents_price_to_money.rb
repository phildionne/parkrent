class ConvertRentsPriceToMoney < ActiveRecord::Migration

  def up
    remove_column(:rents, :price)
    add_money(:rents, :price)
  end

  def down
    add_column(:rents, :price)
    remove_money(:rents, :price)
  end
end
