class ContentItemsAmazon < ActiveRecord::Base
	scope :profileByItem ,(lambda do |profile_id| 
		where({:id => profile_id})
	end)
	has_one :content_items, :dependent => :destroy
  attr_accessible :authors, :currency, :ean, :edition, :images, :isbn, :item_id, :manufacturer, :number_of_pages, :publish_date, :publisher, :studio, :title, :uri
end
