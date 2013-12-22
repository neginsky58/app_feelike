class AddIsActiveToUsersContentItems < ActiveRecord::Migration
  def up
    add_column :users_content_items, :is_active, :boolean
  end

  def down
    remove_column :users_content_items, :is_active
  end
end
