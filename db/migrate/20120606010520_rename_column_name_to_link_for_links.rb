class RenameColumnNameToLinkForLinks < ActiveRecord::Migration
  def up
    rename_column :links, :name, :url
  end

  def down
    rename_column :links, :url, :name
  end
end
