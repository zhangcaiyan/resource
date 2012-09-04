class AddColumnCategoryToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :category, :string

  end
end
