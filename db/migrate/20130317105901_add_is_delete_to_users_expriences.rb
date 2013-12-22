class AddIsDeleteToUsersExpriences < ActiveRecord::Migration
  def up
    add_column :users_expriences, :is_delete, :boolean
  end

  def down
    remove_column :users_expriences, :is_delete
  end
end
