class UsersExprienceCategories2Tags < ActiveRecord::Base
  attr_accessible :cat_id, :cat_tag_id
  def self.findMatch(cat_id ,name)
  	isMatch = false
  	self.where({cat_id:cat_id}).each do |item|
  		tags = UsersExprienceCategoriesTags.where ({id:item.cat_tag_id})
  		tags = tags.where("lower(name) like ?" , name)
  		if tags.nil? || tags.size != 0 
  			isMatch = true
  		end
  	end
  	isMatch
  end
end
