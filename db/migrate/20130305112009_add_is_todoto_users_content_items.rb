class AddIsTodotoUsersContentItems < ActiveRecord::Migration
  def up
    add_column :users_content_items, :is_todo, :boolean
    add_column :users_content_items, :is_feelike, :boolean
  end

  def down
    remove_column :users_content_items, :is_todo
    remove_column :users_content_items, :is_feelike
  end
end
