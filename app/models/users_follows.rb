class UsersFollows < ActiveRecord::Base
  belongs_to :users
  scope :followersWithPrivacyMode ,(lambda do |user_id|
  	data = self.select("users_follows.ref_user_id,users_follows.user_id")
  	.joins ("INNER JOIN users_settings on users_settings.user_id = users_follows.user_id and users_settings.is_private_post = false")
		if data.size != 0
			data = data.where("users_follows.user_id = ?",user_id)
		end
		data
	end)
  scope :followers ,(lambda do |user_id|
    joins("left JOIN users_profiles on users_profiles.user_id =users_follows.user_id")
		.where ({:ref_user_id =>user_id})
	end)

	scope :following ,(lambda do |user_id| 
    joins("left JOIN users_profiles on users_profiles.user_id =users_follows.ref_user_id")
		.where ({:user_id =>user_id})
	end)
  attr_accessible :ref_user_id ,:user_id


  def self.isExists(ref_user_id,user_id)
    if self.where({ref_user_id:ref_user_id,user_id:user_id}).size ==1 
      true
    else
      false
    end
  end
end
