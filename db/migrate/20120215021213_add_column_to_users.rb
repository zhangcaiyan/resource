# coding: utf-8 

class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :address, :string
    add_column :users, :region_id, :integer
    add_column :users, :city_id, :integer 
    add_column :users, :phone, :string 
    add_column :users, :mobile_phone, :string 
    add_column :users, :zip_code, :string 
    add_column :users, :qq, :string
    add_column :users, :msn, :string
    add_column :users, :fax, :string
    add_column :users, :company_url, :string
    add_column :users, :category, :string
  end
end
