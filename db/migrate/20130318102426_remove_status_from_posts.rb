class RemoveStatusFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :status
  end

  def down
  end
end
