class AddColumnMemberAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member_at, :datetime
  end
end
