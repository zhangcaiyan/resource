class RemoveTableDongtaisJiagesHangqingsToComments < ActiveRecord::Migration
  def up
    drop_table :dongtais
    drop_table :hangqings
    drop_table :jiages
  end

  def down
  end
end
