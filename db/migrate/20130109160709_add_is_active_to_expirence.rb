class AddIsActiveToExpirence < ActiveRecord::Migration
  def self.up
    add_column :expriences, :is_active, :boolean
  end

  def self.down
    remove_column :expriences, :is_active
  end
end
