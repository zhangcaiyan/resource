class AddColumnBusinessCategoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :business_category, :string
  end
end
