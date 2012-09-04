class CreateShoucangs < ActiveRecord::Migration
  def change
    create_table :shoucangs do |t|
      t.integer :user_id
      t.integer :transaction_id

      t.timestamps
    end
  end
end
