class ContentItemAgeRange < ActiveRecord::Base
  belongs_to :content_items
  belongs_to :age_ranges
  attr_accessible :title, :body
end
