class CreateContentItemsYoutubes < ActiveRecord::Migration
  def change
    create_table :content_items_youtubes do |t|
      t.text :embed_uri
      t.text :image_uri

      t.timestamps
    end
  end
end
