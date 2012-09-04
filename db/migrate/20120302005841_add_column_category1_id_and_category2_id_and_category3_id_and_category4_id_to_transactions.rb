class AddColumnCategory1IdAndCategory2IdAndCategory3IdAndCategory4IdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :category1_id, :integer
    add_column :transactions, :category2_id, :integer
    add_column :transactions, :category3_id, :integer
    add_column :transactions, :category4_id, :integer
  end
end
