class CreateUserExpiranceActivityToAccessTypes < ActiveRecord::Migration
  def change
    create_table :user_expirance_activity_to_access_types do |t|
      t.belongs_to :type_id
      t.belongs_to :ue_id

      t.timestamps
    end
    add_index :user_expirance_activity_to_access_types, :type_id_id
    add_index :user_expirance_activity_to_access_types, :ue_id_id
  end
end
