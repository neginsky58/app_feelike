class AddIsActiveToPosts < ActiveRecord::Migration
    
	def self.up
    add_column :posts, :is_active, :boolean
  end

  def self.down
    remove_column :posts, :is_active
  end
end
