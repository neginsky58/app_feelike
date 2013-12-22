class AddUsersExprienceToName < ActiveRecord::Migration

	def self.up
    add_column :users_expriences, :name, :string
  end

  def self.down
    remove_column :users_expriences, :name
  end
end
