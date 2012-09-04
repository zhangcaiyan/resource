class AddColumnIsValidToCompanyPrices < ActiveRecord::Migration
  def change
    add_column :company_prices, :is_valid, :boolean, default: true
  end
end
