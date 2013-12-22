class AddIsActiveToFeeling < ActiveRecord::Migration
  def self.up
    add_column :feelings, :is_active, :boolean
  end

  def self.down
    remove_column :feelings, :is_active
  end
end
