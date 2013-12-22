class AddfeelingtoUsersContentItems < ActiveRecord::Migration
  def up
    add_column :users_content_items, :feeling_id, :integer
    add_index(:users_content_items, :feeling_id)
  end

  def down
    remove_column :users_content_items, :feeling_id
    remove_index(:users_content_items, :feeling_id)
  end
end
