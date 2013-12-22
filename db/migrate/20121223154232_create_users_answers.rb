class CreateUsersAnswers < ActiveRecord::Migration
  def self.up
    create_table :users_answers do |t|
      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :answer, :class_name => "Answers", :null => false

      t.timestamps
    end
    add_index :users_answers, :user_id
    add_index :users_answers, :answer_id
  end
  def self.down
    drop_table :users_answers
  end
end
