class AddColumnForumToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :forum, :string

  end
end
