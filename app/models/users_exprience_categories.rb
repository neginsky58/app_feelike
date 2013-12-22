class UsersExprienceCategories < ActiveRecord::Base
  attr_accessible :name
  def self.isExists(id)
    if self.where(:id => id).size ==1 
      false
    else
      true
    end
  end
end
