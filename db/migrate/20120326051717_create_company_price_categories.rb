class CreateCompanyPriceCategories < ActiveRecord::Migration
  def change
    create_table :company_price_categories do |t|
      t.string :name
      t.string :ancestry

      t.timestamps
    end
  end
end
