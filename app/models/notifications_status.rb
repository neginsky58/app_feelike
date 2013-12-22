class NotificationsStatus < ActiveRecord::Base
  attr_accessible :is_feelike, :is_following, :is_ue_following, :is_ue_p
  def self.isExists(item_id) 
    isExisted = false
    if self.find_by_id(item_id).nil?
      isExisted = true
    end
    isExisted
  end
end
