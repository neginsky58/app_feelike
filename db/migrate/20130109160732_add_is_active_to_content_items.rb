class AddIsActiveToContentItems < ActiveRecord::Migration
  def self.up
    add_column :content_items, :is_active, :boolean
  end

  def self.down
    remove_column :content_items, :is_active
  end
end
