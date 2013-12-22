class CreateContentItemsFaculties < ActiveRecord::Migration
  def change
    create_table :content_items_faculties do |t|

      t.timestamps
    end
  end
end
