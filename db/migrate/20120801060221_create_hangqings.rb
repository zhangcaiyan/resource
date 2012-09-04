class CreateHangqings < ActiveRecord::Migration
  def change
    create_table :hangqings do |t|
      t.string :title
      t.text :desc
      t.date :published_at
      t.integer :resource_id

      t.timestamps
    end
  end
end
