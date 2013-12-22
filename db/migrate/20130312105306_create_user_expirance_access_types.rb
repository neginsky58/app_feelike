class CreateUserExpiranceAccessTypes < ActiveRecord::Migration
  def change
    create_table :user_expirance_access_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
