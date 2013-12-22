class FixContentItemsFromPost < ActiveRecord::Migration
  def up
  	rename_column :posts, :contentItem_id, :content_item_id
  	remove_index :posts, :contentItem_id
    add_index :posts, :content_item_id
  end

  def down
  	rename_column :posts, :content_item_id, :contentItem_id
  	add_index :posts, :contentItem_id
    remove_index :posts, :content_item_id
  end
end
