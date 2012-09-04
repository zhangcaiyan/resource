class CreateDongtais < ActiveRecord::Migration
  def change
    create_table :dongtais do |t|
      t.string :title
      t.text :desc
      t.date :published_at
      t.integer :resource_id
      t.integer :region_id

      t.timestamps
    end
  end
end
