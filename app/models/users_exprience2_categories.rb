class UsersExprience2Categories < ActiveRecord::Base
  attr_accessible :ue_categoy_id, :ue_id
  def self.appendUE(user_exp_id , item)
  	searchText = "%" + item.downcase + "%"
  	UsersExprienceCategories.all.each do |item| 
      isMatched = self.where({ue_categoy_id: item.id , ue_id: user_exp_id})
      if UsersExprienceCategories2Tags.findMatch(item.id , searchText) && isMatched.size == 0
      	self.create({
      		ue_categoy_id: item.id,
      		ue_id: user_exp_id
      	})
      end
  	end
  end
end
