class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :ue_id
      t.integer :notification_status_id
      t.boolean :is_sent
      t.boolean :is_read

      t.timestamps
    end
  end
end
