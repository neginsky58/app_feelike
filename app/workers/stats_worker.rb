class StatsWorker 
  include Sidekiq::Worker
  

  def perform
  	Sidekiq::RetrySet.new.clear
  	begin 
	  	#get total feelikes based its content items
	  	content_Items = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now}).select("content_item_id").uniq
	  	unless (content_Items.nil?)
	  		content_Items.each{|item| analyze_item(item.content_item_id)} unless content_Items.size == 0
	  	end
	  rescue => e
	  	logger.error e
	  end
  end
  def analyze_item (item_id)
  	total_overall_feelike = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now , :content_item_id => item_id ,  :is_feelike => true}).size
  	total_overall_todo = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now , :content_item_id => item_id ,  :is_todo => true}).size
  	total_overall_ue = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now , :content_item_id => item_id ,  :is_feelike => true}).where("users_content_items.user_exprance_id != 0").size
  	total_overall_comments  = PostsComments.commentByItem(item_id).size
  	total_overall = (total_overall_todo + (total_overall_ue+10) + total_overall_comments + total_overall_feelike)
  	#let's update overall rating 
  	StatsContentItems.create({
  		:item_id => item_id , 
  		:feeling_id => nil , 
  		:todo_counter => total_overall_todo, 
  		:ue_counter => total_overall_ue, 
  		:comments_counter => total_overall_comments,
  		:overall_counter => total_overall , 
  		:feelike_count => total_overall_feelike
  	})
  	Feelings.all.each do |feeling_item| 
  		total_feelike = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now ,:feeling_id => feeling_item.id , :content_item_id => item_id ,  :is_feelike => true}).size
	  	total_todo = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now ,:feeling_id => feeling_item.id , :content_item_id => item_id ,  :is_todo => true}).size
	  	total_ue = UsersContentItems.where({:created_at  =>7.day.ago...DateTime.now ,:feeling_id => feeling_item.id , :content_item_id => item_id ,  :is_feelike => true}).where("users_content_items.user_exprance_id != 0").size
	  	total_comments  = PostsComments.commentByItem(item_id).size
  		total = (total_todo + (total_ue+10) + total_comments + total_feelike)
	  	#let's update overall rating 
	  	StatsContentItems.create({
	  		:item_id => item_id , 
	  		:feeling_id => feeling_item.id , 
	  		:todo_counter => total_todo, 
	  		:ue_counter => total_ue, 
	  		:comments_counter => total_comments, 
	  		:overall_counter => total ,
	  		:feelike_count => total_feelike
	  	})
  	end
  end
end