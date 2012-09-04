class ChangeColumnPublishAtToRefreshedAtForTransactions < ActiveRecord::Migration
  def up
    rename_column :transactions, :publish_at, :refreshed_at
  end

  def down
    rename_column :transactions, :refreshed_at, :publish_at
  end
end
