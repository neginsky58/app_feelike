class ContentItemsYoutube < ActiveRecord::Base
	scope :profileByItem ,(lambda do |profile_id| 
		where({:id => profile_id})
	end)
	has_one :content_items, :dependent => :destroy
  attr_accessible :embed_uri, :image_uri,:youtube_id,:duration, :mobile_uri, :author
end
