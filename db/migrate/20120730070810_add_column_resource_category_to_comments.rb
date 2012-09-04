class AddColumnResourceCategoryToComments < ActiveRecord::Migration
  def change
    add_column :comments, :resource_category, :string

  end
end
