class UsersSocals < ActiveRecord::Base
  belongs_to :users

	scope :byUser ,(lambda do |user_id| 
		where('users_id  = ?',user_id)
	end)
  scope :byFbID ,(lambda do |fb_id| 
    where('fb_id = ?' , fb_id)
  end)
	
  scope :byTokenFacebook ,(lambda do |token| 
		where('has_facebook  = true and facebook_token = ?',token)
	end)
	scope :byTokenTwitter ,(lambda do |token| 
		where('has_twitter  = true and twitter_token = ?',token)
	end)
  attr_accessible :users_id,:facebook_token, :has_facebook, :has_twitter, :twitter_token
  def connectFacebook(fb_id , token) 
  	self.has_facebook = true
  	self.facebook_token = token
  	self.save
  end
  def unConnectFacebook
  	self.has_facebook = false
  	self.facebook_token = ''
  	self.save
  end
  def connectTwittwer(token) 
  	self.has_twitter = true
  	self.twitter_token = token
  	self.save
  end
  def unConnectTwittwer
  	self.has_twitter = false
  	self.twitter_token = ''
  	self.save
  end
end
