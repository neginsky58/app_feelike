class UsersExprienceImages < ActiveRecord::Base
  belongs_to :users
  attr_accessible :id,:user_exp_id , :user_id, :image_id
  scope :byExp ,(lambda do |ue_id|  
  	where({:user_exp_id => ue_id})
  end)
end
