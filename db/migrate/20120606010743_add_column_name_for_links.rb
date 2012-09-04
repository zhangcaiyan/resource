class AddColumnNameForLinks < ActiveRecord::Migration
  def up
    add_column :links, :name, :string 
  end

  def down
    remove_column :links, :name
  end
end
