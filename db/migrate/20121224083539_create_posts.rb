class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :feeling, :class_name => "Feeling", :null => false
      t.belongs_to :contentItem, :class_name => "ContentItems", :null => false
      t.belongs_to :userExprience, :class_name => "UsersExpriences", :null => true
      t.text :content, :null => false
      t.string :status, :null => false

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :feeling_id
    add_index :posts, :contentItem_id
    add_index :posts, :userExprience_id
    end
  def self.down
    drop_table :posts
  end
end
