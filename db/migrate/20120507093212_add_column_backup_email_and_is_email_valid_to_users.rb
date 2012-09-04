class AddColumnBackupEmailAndIsEmailValidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :backup_email, :string
    add_column :users, :is_email_valid, :boolean, default: true
  end
end
