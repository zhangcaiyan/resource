# coding: utf-8 

class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, :default => false

  end
end
