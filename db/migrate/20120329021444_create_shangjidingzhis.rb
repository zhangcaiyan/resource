class CreateShangjidingzhis < ActiveRecord::Migration
  def change
    create_table :shangjidingzhis do |t|
      t.string :keyword
      t.string :info_type
      t.boolean :is_send_email
      t.integer :user_id
      t.integer :region_id
      t.integer :city_id

      t.timestamps
    end
  end
end
