class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.belongs_to :image, :class_name => "Assets"

    	t.boolean  :is_active
      t.timestamps
    end
    add_index :categories, :image_id
  end
end
