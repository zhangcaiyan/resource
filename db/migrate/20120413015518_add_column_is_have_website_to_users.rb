class AddColumnIsHaveWebsiteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_have_website, :boolean, default: false

  end
end
