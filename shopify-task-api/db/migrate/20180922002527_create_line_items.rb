class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.string :title, null: false, default: ""
      t.integer :quantity, null: false, default: 0
      t.decimal :price, null: false, default: 0.0, precision: 10, scale: 2
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
