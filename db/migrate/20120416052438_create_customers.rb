class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :post
      t.string :gender
      t.string :phone
      t.string :mobile_phone
      t.string :fax
      t.string :email
      t.string :company_name
      t.integer :country_id
      t.integer :region_id
      t.integer :city_id
      t.string :address
      t.string :zip_code
      t.string :rating
      t.string :status
      t.text :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
