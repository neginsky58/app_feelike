class CreateContentItemsItunes < ActiveRecord::Migration
  def change
    create_table :content_items_itunes do |t|
      t.integer :track_id
      t.integer :artist_id
      t.integer :collection_id
      t.integer :track_time_millis
      t.string :artist_name
      t.string :collectionArt_name
      t.string :artist_view_uri
      t.string :track_view_uri
      t.string :collection_view_uri
      t.string :preview_uri
      t.string :artwork_uri
      t.float :collection_price
      t.float :track_price
      t.string :country
      t.string :currency
      t.string :genre
      t.string :long_description
      t.string :item_type

      t.timestamps
    end
  end
end
