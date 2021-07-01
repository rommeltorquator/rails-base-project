class AddTransactionTypeToPurchaseTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_transactions, :transaction_type, :string
  end
end
