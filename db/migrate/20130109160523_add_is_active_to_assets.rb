class AddIsActiveToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :is_active, :boolean
  end

  def self.down
    remove_column :assets, :is_active
  end
end
