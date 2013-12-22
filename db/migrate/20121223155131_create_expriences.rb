class CreateExpriences < ActiveRecord::Migration
  def change
    create_table :expriences do |t|
      t.primary_key :id
      t.string :name

      t.timestamps
    end
  end
end
