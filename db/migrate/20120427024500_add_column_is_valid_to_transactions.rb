class AddColumnIsValidToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :is_valid, :boolean, default: true

  end
end
