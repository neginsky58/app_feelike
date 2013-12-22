class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.primary_key :id
      t.string :name

      t.timestamps
    end
  end
end
