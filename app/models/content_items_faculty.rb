class ContentItemsFaculty < ActiveRecord::Base
	scope :profileByItem ,(lambda do |profile_id| 
		where({:id => profile_id})
	end)
	has_one :content_items, :dependent => :destroy
  # attr_accessible :title, :body
end
