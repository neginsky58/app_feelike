class CreateUsersContentItemsComments < ActiveRecord::Migration
  def change
    create_table :users_content_items_comments do |t|
      t.belongs_to :users
      t.belongs_to :content_items
      t.text :comment

      t.timestamps
    end
  end
end
