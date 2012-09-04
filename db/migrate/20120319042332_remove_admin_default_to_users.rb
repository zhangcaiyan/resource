class RemoveAdminDefaultToUsers < ActiveRecord::Migration
  def up
    change_column_default :users, :admin, nil
  end

  def down
  end

end
