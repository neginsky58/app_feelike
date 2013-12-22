class UserExpiranceActivityToAccessType < ActiveRecord::Base
  belongs_to :type_id
  belongs_to :ue_id
  # attr_accessible :title, :body
end
