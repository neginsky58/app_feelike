class UsersAnswers < ActiveRecord::Base
  belongs_to :users
  belongs_to :Answers
  attr_accessible :title, :body
end
