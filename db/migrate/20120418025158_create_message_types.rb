class CreateMessageTypes < ActiveRecord::Migration
  def change
    create_table :message_types do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
