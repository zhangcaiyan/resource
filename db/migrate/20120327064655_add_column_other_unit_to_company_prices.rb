class AddColumnOtherUnitToCompanyPrices < ActiveRecord::Migration
  def change
    add_column :company_prices, :other_unit, :string
  end
end
