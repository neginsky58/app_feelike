class AddRefUserIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :ref_user_id, :integer
  end
end
