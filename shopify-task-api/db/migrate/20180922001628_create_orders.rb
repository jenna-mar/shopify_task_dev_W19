class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total_price, null: false,  default: 0.0
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
