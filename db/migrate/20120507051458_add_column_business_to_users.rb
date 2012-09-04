class AddColumnBusinessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :business, :text

  end
end
