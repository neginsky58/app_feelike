class AddDurationToContentItemsYoutube < ActiveRecord::Migration
  def change
    add_column :content_items_youtubes, :duration, :integer
  end
end
