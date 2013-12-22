class FixContentItemIdFromUserExpirance < ActiveRecord::Migration
  def up
  	rename_column :users_expriences, :contentItem_id, :content_item_id
  	remove_index :users_expriences, :contentItem_id
    add_index :users_expriences, :content_item_id
  end

  def down
  	rename_column :users_expriences, :content_item_id, :contentItem_id
  	add_index :users_expriences, :contentItem_id
    remove_index :users_expriences, :content_item_id
  end
end
