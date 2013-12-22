class FixCloumesNamesToUsersSettings < ActiveRecord::Migration
  def change
    rename_column :users_settings, :is_comment_email, :comment_status
    rename_column :users_settings, :is_experience_email, :experience_status
    rename_column :users_settings, :is_like_email, :experience_p_status
    rename_column :users_settings, :is_feelings_email, :feelike_status
    rename_column :users_settings, :is_follows_email, :follows_status
  end
end
