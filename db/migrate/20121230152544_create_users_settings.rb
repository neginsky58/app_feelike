class CreateUsersSettings < ActiveRecord::Migration
  def change
    create_table :users_settings do |t|
      t.belongs_to :user, :class_name => "User", :null => false
      t.boolean :is_like_email
      t.boolean :is_feelings_email
      t.boolean :is_comment_email
      t.boolean :is_follows_email
      t.boolean :is_experience_email

      t.timestamps
    end
    add_index :users_settings, :user_id
  end
end
