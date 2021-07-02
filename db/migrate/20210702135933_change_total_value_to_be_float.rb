class ChangeTotalValueToBeFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :purchase_transactions, :total_value, :float
  end
end
