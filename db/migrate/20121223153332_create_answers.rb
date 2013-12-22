class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question, :class_name => "Questions", :null => false
      t.text :content, :null => false

      t.timestamps
    end
    add_index :answers, :question_id
  end
end
