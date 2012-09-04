class ChangeMemberDefaultValueForUsers < ActiveRecord::Migration
  def up
    change_column_default :users, :member, :a
  end

  def down
    change_column_default :users, :member, "0"
  end
end
