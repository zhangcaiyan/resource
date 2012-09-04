class AddColumnIsToSoftDeletedAndIsFromSoftDeletedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_from_soft_deleted, :boolean
    add_column :messages, :is_to_soft_deleted, :boolean
  end
end
