class RemoveContentItemIdFromUsersExpriances < ActiveRecord::Migration
  def up
    remove_index :users_expriences, :content_item_id
    remove_column :users_expriences, :content_item_id
  end

  def down
    add_column :users_expriences, :content_item_id, :integer
  	add_index :users_expriences, :content_item_id
  end
end
