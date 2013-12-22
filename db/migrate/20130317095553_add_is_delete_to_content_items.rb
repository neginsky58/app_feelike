class AddIsDeleteToContentItems < ActiveRecord::Migration
  def up
    add_column :content_items, :is_delete, :boolean
  end

  def down
    remove_column :content_items, :is_delete
  end
end
