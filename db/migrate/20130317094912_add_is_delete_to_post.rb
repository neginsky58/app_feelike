class AddIsDeleteToPost < ActiveRecord::Migration
  def up
    add_column :posts, :is_delete, :boolean
  end

  def down
    remove_column :posts, :is_delete
  end
end
