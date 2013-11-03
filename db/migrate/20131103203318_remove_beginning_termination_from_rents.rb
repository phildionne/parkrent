class RemoveBeginningTerminationFromRents < ActiveRecord::Migration
  def change
    remove_columns(:rents, :beginning, :termination)
  end
end
