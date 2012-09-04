class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.has_attached_file :image
      t.integer :transaction_id
      t.integer :user_id
      t.timestamps
    end
  end


end
