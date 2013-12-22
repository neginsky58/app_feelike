class CreateParams < ActiveRecord::Migration
  def change
    create_table :params do |t|
      t.primary_key :id
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
