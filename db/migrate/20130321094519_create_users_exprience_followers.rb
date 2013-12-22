class CreateUsersExprienceFollowers < ActiveRecord::Migration
  def change
    create_table :users_exprience_followers do |t|
      t.belongs_to :users
      t.belongs_to :users_expriences

      t.timestamps
    end
    add_index :users_exprience_followers, :users_id
    add_index :users_exprience_followers, :users_expriences_id
  end
end
