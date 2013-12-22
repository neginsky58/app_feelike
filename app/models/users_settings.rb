class UsersSettings < ActiveRecord::Base
	scope :byUser, lambda { |user| where("user_id = ?", user) }
  belongs_to :users
  attr_accessible :user_id,:comment_status, :experience_status, :experience_p_status, :follows_status,:feelike_status,:is_private_post,:mobile_token

  #will update the settings
  def updateNotifications(data)
    self.comment_status = data[:comment_status].to_i
    self.experience_status = data[:experience_status].to_i
    self.experience_p_status = data[:experience_p_status].to_i
    self.feelike_status = data[:feelike_status].to_i
    self.follows_status = data[:follows_status].to_i
    save
  end
  def toggelPrivateMode
    self.is_private_post = !self.is_private_post
    save
  end
end
