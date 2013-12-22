class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.string :name
      t.string :title
      t.text :content
      t.boolean :is_published

      t.timestamps
    end
  end
end
