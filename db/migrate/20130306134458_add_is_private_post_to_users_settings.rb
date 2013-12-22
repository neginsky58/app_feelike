class AddIsPrivatePostToUsersSettings < ActiveRecord::Migration
  def up
    add_column :users_settings, :is_private_post, :boolean
  end

  def down
    remove_column :users_settings, :is_private_post
  end
end
