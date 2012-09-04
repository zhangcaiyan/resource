class CreateHangqingbaojia < ActiveRecord::Migration
  def change
    create_table :hangqingbaojia do |t|
      t.string :title
      t.text :desc
      t.date :published_at
      t.integer :resource_id
      t.integer :category_id
      t.integer :region_id
      t.string :type

      t.timestamps
    end
  end
end
