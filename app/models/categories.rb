class Categories < ActiveRecord::Base
	scope :active , where(:is_active => true)
  belongs_to :Assets
  attr_accessible :image, :id, :name,:is_active
end
