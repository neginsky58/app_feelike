class CreateNotificationsStatuses < ActiveRecord::Migration
  def change
    create_table :notifications_statuses do |t|
      t.boolean :is_following
      t.boolean :is_ue_following
      t.boolean :is_ue_p
      t.boolean :is_feelike

      t.timestamps
    end
  end
end
