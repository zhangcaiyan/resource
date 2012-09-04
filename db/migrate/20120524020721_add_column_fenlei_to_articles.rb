class AddColumnFenleiToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :fenlei, :string
  end
end
