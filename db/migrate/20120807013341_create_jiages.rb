class CreateJiages < ActiveRecord::Migration
  def change
    create_table :jiages do |t|
      t.string :title
      t.text :desc
      t.date :published_at
      t.integer :resource_id
      t.integer :category_id

      t.timestamps
    end
  end
end
