class RemovecommentstoUsersContentItems < ActiveRecord::Migration
  def up
    remove_column :users_content_items, :comments
  end

  def down
    add_column :users_content_items, :comments , :text
  end
end
