class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :category
      t.text :desc
      t.date :published_at

      t.timestamps
    end
  end
end
