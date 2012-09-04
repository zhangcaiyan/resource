class RemoveColumnResourceCategoryToComments < ActiveRecord::Migration
  def up
    remove_column :comments, :resource_category
  end

  def down
    add_column :comments, :resource_category, :string
  end
end
