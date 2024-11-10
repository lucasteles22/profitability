class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :kind, null: false, limit: 50
      t.date :date, null: false
      t.string :report_type, null: false, limit: 100
      t.string :product, null: false, limit: 1000
      t.string :broker, null: false, limit: 200
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false, precision: 8, scale: 2
      t.decimal :total_value, null: false, precision: 8, scale: 2

      t.timestamps
    end

    add_index :reports, [ :kind, :date, :report_type, :product, :broker, :quantity ], unique: true
  end
end
