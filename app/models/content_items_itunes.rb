class ContentItemsItunes < ActiveRecord::Base
	scope :profileByItem ,(lambda do |profile_id| 
		where({:id => profile_id})
	end)
	has_one :content_items, :dependent => :destroy
  attr_accessible :artist_id, :artist_name, :artist_view_uri, :artwork_uri, :collectionArt_name, :collection_id, :collection_price, :collection_view_uri, :country, :currency, :genre, :long_description, :preview_uri, :track_id, :track_price, :track_time_millis, :track_view_uri, :item_type
end
