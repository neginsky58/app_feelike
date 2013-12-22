class AddIsPrivateToUsersExprience < ActiveRecord::Migration
	def self.up
    add_column :users_expriences, :is_private, :boolean
  end

  def self.down
    remove_column :users_expriences, :is_private
  end
end
