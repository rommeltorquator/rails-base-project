class CreateCashes < ActiveRecord::Migration[6.0]
  def change
    create_table :cashes do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.decimal :amount

      t.timestamps
    end
  end
end
