class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :title
      t.string :info_type
      t.string :source
      t.string :manufacture
      t.float :quantity
      t.string :quantity_unit
      t.string :location
      t.string :price_unit
      t.boolean :is_price_scope
      t.float :min_price
      t.float :max_price
      t.string :valid_time
      t.string :provide_statu
      t.integer :provide_quantity
      t.string :goods_type
      t.text :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
