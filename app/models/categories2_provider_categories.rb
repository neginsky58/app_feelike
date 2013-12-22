class Categories2ProviderCategories < ActiveRecord::Base
	scope :by_match , lambda{ |providerCategory , category| 
    unless providerCategory.nil? && providerName.nil?
      joins('LEFT JOIN categories ON categories.id = categories2_provider_categories.categories_id').
      joins('LEFT JOIN provider_categories ON provider_categories.id = categories2_provider_categories.provider_categories_id').
  		where(
  			:categories_id => Categories.active.where({:name => category}).select('id'),
  			:provider_categories_id => ProviderCategories.active.where({:name => providerCategory}).select('id')).
      select("categories_id as category_id , provider_categories_id , categories.name as categoryName")
    else 
      nil
    end
  }
  scope :by_provider , lambda { |providerName,providerCategory|
    unless providerCategory.nil? && providerName.nil?
      joins('LEFT  JOIN categories ON categories.id = categories_id').
      joins('LEFT  JOIN provider_categories ON provider_categories.id = provider_categories_id').
    	where(
        :provider_categories_id => ProviderCategories.active.where({:name => providerCategory , :provider_name => providerName}).select('id')).
      select("categories_id as category_id , provider_categories_id , categories.name as categoryName")
    else 
      nil
    end
  }
  belongs_to :categories
  belongs_to :provider_categories
  attr_accessible :categories_id, :provider_categories_id
end
