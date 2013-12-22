class ProviderCategories < ActiveRecord::Base
	scope :active , where(:is_active => true)
  attr_accessible :name , :provider_name,:is_active
end
