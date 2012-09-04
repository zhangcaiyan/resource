class AddColumnPublishAtToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :publish_at, :datetime

  end
end
