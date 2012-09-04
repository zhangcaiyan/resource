#coding: utf-8

class AddColumnCountryIdToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :country_id, :integer
    Region.update_all(country_id: Country.find_by_name('中国').id)
  end

  def self.down
    remove_column :regions, :country_id
  end

end
