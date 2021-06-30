class CreateWatchedStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :watched_stocks do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.string :symbol
      t.string :company
      t.decimal :latest_price
      t.decimal :avg_total_volume
      t.string :change_percent_s

      t.timestamps      
    end
  end
end
