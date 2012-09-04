class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :desc
      t.integer :from_id
      t.integer :to_id
      t.boolean :is_from_deleted
      t.boolean :is_to_deleted
      t.boolean :is_read

      t.timestamps
    end
  end
end
