class CreateTransactionTypes < ActiveRecord::Migration
  def change
    create_table :transaction_types do |t|
      t.string :name
      t.text :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
