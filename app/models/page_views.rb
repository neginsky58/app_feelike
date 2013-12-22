class PageViews < ActiveRecord::Base
  attr_accessible :content, :is_published, :name, :title
end
