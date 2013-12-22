class CreateUsersExpriences < ActiveRecord::Migration
  def self.up
    create_table :users_expriences do |t|
      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :contentItem, :class_name => "ContentItems", :null => false
      t.belongs_to :exprience, :class_name => "Exprience", :null => false
      t.belongs_to :image, :class_name => "Assets"
      t.text :content, :null => false

      t.timestamps
    end
    add_index :users_expriences, :user_id
    add_index :users_expriences, :image_id
    add_index :users_expriences, :contentItem_id
    add_index :users_expriences, :exprience_id
  end
  def self.down
    drop_table :users_expriences
  end

end
