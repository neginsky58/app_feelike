class DropExprienceTable < ActiveRecord::Migration
  def up
  	drop_table :expriences
  end

  def down
  	create_table :expriences do |t|
      t.primary_key :id
      t.string :name

      t.timestamps
    end
  end
end
