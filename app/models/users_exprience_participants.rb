class UsersExprienceParticipants < ActiveRecord::Base
  belongs_to :users
  attr_accessible :user_id, :user_exp_id

  def self.isExists(user_id,user_exp_id)
    if self.where({:user_id => user_id,:user_exp_id => user_exp_id}).size ==1 
      false
    else
      true
    end
  end
end
