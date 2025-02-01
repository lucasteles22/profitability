class CreateTradings < ActiveRecord::Migration[8.0]
  def change
    create_table :tradings do |t|
      t.string :kind
      t.date :trading_date
      t.string :market_type
      t.string :code
      t.text :broker
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :total_value
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :tradings,
      [ :user_id, :kind, :trading_date, :market_type, :code, :broker, :quantity ],
      unique: true
  end
end
