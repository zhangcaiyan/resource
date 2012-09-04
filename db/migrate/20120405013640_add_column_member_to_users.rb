class AddColumnMemberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member, :string, default: "0"
  end
end
