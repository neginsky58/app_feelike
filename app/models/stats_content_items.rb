class StatsContentItems < ActiveRecord::Base
  attr_accessible :comments_counter, :feelike_count, :item_id ,:feeling_id, :todo_counter, :ue_counter,:overall_counter
  scope :overall , where({:feeling_id => nil, :created_at  =>7.day.ago...DateTime.now})
  scope :by_feelings  , (lambda do |feeling_id|
  	where({:feeling_id => feeling_id, :created_at  =>7.day.ago...DateTime.now}).uniq
  end)
  validates :item_id, :presence => true
end
