class RenameUserContentItemsCommentsToPostComments < ActiveRecord::Migration
  def up
  	rename_table :users_content_items_comments, :posts_comments
    add_column :posts_comments, :post_id, :integer
    add_index :posts_comments, :post_id
  end

  def down
    remove_column :posts_comments, :post_id
    remove_index :posts_comments, :post_id
  	rename_table :posts_comments, :users_content_items_comments
  end
end
