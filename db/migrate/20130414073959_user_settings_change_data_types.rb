class UserSettingsChangeDataTypes < ActiveRecord::Migration
  def up
    remove_column :users_settings, :is_like_email
    remove_column :users_settings, :is_feelings_email
    remove_column :users_settings, :is_comment_email
    remove_column :users_settings, :is_follows_email
    remove_column :users_settings, :is_experience_email
  	add_column :users_settings, :is_like_email, :integer
  	add_column :users_settings, :is_feelings_email, :integer
  	add_column :users_settings, :is_comment_email, :integer
  	add_column :users_settings, :is_follows_email, :integer
  	add_column :users_settings, :is_experience_email, :integer
  end

  def down
    remove_column :users_settings, :is_like_email
    remove_column :users_settings, :is_feelings_email
    remove_column :users_settings, :is_comment_email
    remove_column :users_settings, :is_follows_email
    remove_column :users_settings, :is_experience_email
  	add_column :users_settings, :is_like_email, :boolean
  	add_column :users_settings, :is_feelings_email, :boolean
  	add_column :users_settings, :is_comment_email, :boolean
  	add_column :users_settings, :is_follows_email, :boolean
  	add_column :users_settings, :is_experience_email, :boolean
  end
end
