class CreateUsersExprienceImages < ActiveRecord::Migration
  def self.up
    create_table :users_exprience_images do |t|
      t.belongs_to :user_exp, :class_name => "UsersExprience", :null => false
      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :image, :class_name => "Assets", :null => false

      t.timestamps
    end
    add_index :users_exprience_images, :image_id
    add_index :users_exprience_images, :user_id
    add_index :users_exprience_images, :user_exp_id
  end
  def self.down
    drop_table :users_exprience_images
  end
end
