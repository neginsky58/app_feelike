class UsersExprienceFollowers < ActiveRecord::Base
  belongs_to :users
  belongs_to :usersExprience
  attr_accessible :users_id, :users_expriences_id
  scope :following ,(lambda do |ue_id|  
  	joins("left JOIN users_profiles on users_profiles.user_id =users_exprience_followers.users_id")
  	.where({:users_expriences_id => ue_id})
  end)
  scope :follower ,(lambda do |user_id|  
  	joins("left JOIN users_profiles on users_profiles.user_id =users_exprience_followers.users_id")
  	.where({:users_id => user_id})
  end)


  def self.isExists(ue_id,user_id)
    if self.where({users_expriences_id:ue_id,users_id:user_id}).size ==1 
      true
    else
      false
    end
  end
end
