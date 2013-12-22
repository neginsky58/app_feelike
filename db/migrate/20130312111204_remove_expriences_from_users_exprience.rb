class RemoveExpriencesFromUsersExprience < ActiveRecord::Migration
  def up
    remove_column :users_expriences, :exprience_id
  end

  def down
    add_column :users_expriences, :exprience_id, :integer, :null => false
  end
end
