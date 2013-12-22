class CreateUsersExprienceParticipants < ActiveRecord::Migration
  def change
    create_table :users_exprience_participants do |t|

      t.belongs_to :user_exp, :class_name => "UsersExprience", :null => false
      t.belongs_to :user, :class_name => "User", :null => false

      t.timestamps
    end
    add_index :users_exprience_participants, :user_exp_id
    add_index :users_exprience_participants, :user_id
  end
end
