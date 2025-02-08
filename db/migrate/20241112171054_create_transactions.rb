class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :kind, null: false, limit: 50
      t.date :transaction_date, null: false
      t.string :transaction_type, null: false, limit: 100
      t.string :product, null: false, limit: 1000
      t.string :broker, null: false, limit: 200
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false
      t.decimal :total_value, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :transactions,
      [ :user_id, :kind, :transaction_date, :transaction_type, :product, :broker, :quantity, :unit_price, :total_value ],
      unique: true
  end
end
