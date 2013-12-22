class FamilyGender < ActiveRecord::Base
  attr_accessible :id, :name
	has_many :content_items, :dependent => :destroy
	has_one :users_profiles, :dependent => :destroy
end
