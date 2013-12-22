class AddFbIdToUsersSocals < ActiveRecord::Migration
  def change
    add_column :users_socals, :fb_id, :integer
  end
end
