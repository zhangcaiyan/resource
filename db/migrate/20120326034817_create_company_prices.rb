class CreateCompanyPrices < ActiveRecord::Migration
  def change
    create_table :company_prices do |t|
      t.string :name
      t.string :unit
      t.boolean :is_price_scope
      t.float :min_price
      t.float :max_price
      t.integer :region_id
      t.integer :city_id
      t.string :valid_time
      t.text :desc
      t.integer :user_id
      t.integer :category1_id 
      t.integer :category2_id
      t.integer :category3_id
      t.timestamps
    end
  end
end
