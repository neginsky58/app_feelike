class AddUserExprianceFromUsersContentItems < ActiveRecord::Migration
  def up
    add_column :users_content_items, :user_exprance_id, :integer
    add_index :users_content_items, :user_exprance_id
  end

  def down
    remove_column :users_expriences, :user_exprance_id
    remove_index :users_expriences, :user_exprance_id
  end
end
