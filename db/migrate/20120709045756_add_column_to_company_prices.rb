class AddColumnToCompanyPrices < ActiveRecord::Migration
  def change
    add_column :company_prices, :refreshed_at, :datetime
  end

end
