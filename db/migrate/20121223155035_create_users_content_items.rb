class CreateUsersContentItems < ActiveRecord::Migration
  def self.up
    create_table :users_content_items do |t|
      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :content_item, :class_name => "ContentItems", :null => false
      t.text :comments

      t.timestamps
    end
    add_index :users_content_items, :user_id
    add_index :users_content_items, :content_item_id
  end
  def self.down
    remove_foreign_key(:User)
    drop_table :users_content_items
  end
end
