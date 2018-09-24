class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title, default: ""
      t.text :description
      t.decimal :price, null: false, default: 0.0, precision: 10, scale: 2
      t.string :category
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
