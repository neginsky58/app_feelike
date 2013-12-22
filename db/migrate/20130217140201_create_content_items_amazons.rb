class CreateContentItemsAmazons < ActiveRecord::Migration
  def change
    create_table :content_items_amazons do |t|
      t.integer :item_id
      t.string :ean
      t.hstore :images
      t.string_array :authors
      t.string :isbn
      t.integer :edition
      t.string :currency
      t.integer :number_of_pages
      t.date :publish_date
      t.string :publisher
      t.string :manufacturer
      t.string :studio
      t.string :title
      t.string :uri

      t.timestamps
    end
  end
end
