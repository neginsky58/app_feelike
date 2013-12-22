class CreateUsersFollows < ActiveRecord::Migration
  def change
    create_table :users_follows do |t|
      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :ref_user, :class_name => "User", :null => false
      t.timestamps
    end
    add_index :users_follows, :user_id
    add_index :users_follows, :ref_user_id
  end
end
