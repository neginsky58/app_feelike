class AddYoutubeFieldToContentItemsYoutubes < ActiveRecord::Migration
  def up
    add_column :content_items_youtubes, :author, :string
    add_column :content_items_youtubes, :mobile_uri, :string
    add_column :content_items_youtubes, :youtube_id, :string
  end

  def down
    rename_column :content_items_youtubes, :author
    rename_column :content_items_youtubes, :mobile_uri
    rename_column :content_items_youtubes, :youtube_id
  end
end
