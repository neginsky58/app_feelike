class AddIsActiveToUsersExprience < ActiveRecord::Migration
 
	def self.up
    add_column :users_expriences, :is_active, :boolean
  end

  def self.down
    remove_column :users_expriences, :is_active
  end
end
