class Answers < ActiveRecord::Base
  belongs_to :Questions
  attr_accessible :content, :id
end
