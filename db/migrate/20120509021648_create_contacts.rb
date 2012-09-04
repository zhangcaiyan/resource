class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :gender
      t.boolean :is_public
      t.string :phone
      t.string :cell_phone
      t.string :qq
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
