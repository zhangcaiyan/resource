class ChangeColumnValidTimeForTransactions < ActiveRecord::Migration
  def up
    change_column :transactions, :valid_time, :string
  end

  def down
    change_column :transactions, :valid_time, :integer
  end
end
