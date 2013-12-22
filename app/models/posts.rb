class Posts < ActiveRecord::Base
  belongs_to :users
  belongs_to :feelings
  belongs_to :content_items
  belongs_to :users_expriences
  attr_accessible :content , :asset_id, :create_at, :excution_at, :id, :status, :is_active , :is_delete,:user_id, :feeling_id, :content_item_id, :userExprience_id
	default_scope where(:is_active => true , :is_delete => false)
  
  def updatePost(user_id,feeling_id , content_item_id,asset_id , ue_id , content ,userItemObject)
  	self.content = content
  	self.feeling_id = feeling_id
  	self.content_item_id = content_item_id
    self.asset_id = asset_id
  	self.userExprience_id = ue_id
    userItemObject.feeling_id = feeling_id
    userItemObject.user_exprance_id = exp_id unless ue_id == 0
    userItemObject.save
    save
  end
  def self.isExists(id)
    if self.where(:id => id).size ==1 
      false
    else
      true
    end
  end
end
