class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :kind, null: false, limit: 50
      t.date :date, null: false
      t.string :type, null: false, limit: 100
      t.string :product, null: false, limit: 1000
      t.text :broker, null: false
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false, precision: 8, scale: 2
      t.decimal :total_value, null: false, precision: 8, scale: 2
    end
  end
end
