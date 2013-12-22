class PostsComments < ActiveRecord::Base
	scope :commentByItem ,(lambda do |conetnt_item_id| 
		where({:content_items_id => conetnt_item_id})
	end)
	scope :commentByUser ,(lambda do |user_id| 
		where({:users_id => user_id})
	end)
	scope :byMatch ,(lambda do |post_id,conetnt_item_id,user_id| 
		where({:users_id => user_id,:content_items_id => conetnt_item_id ,:post_id => post_id})
	end)

  attr_accessible :users_id, :content_items_id, :comment,:post_id
end
