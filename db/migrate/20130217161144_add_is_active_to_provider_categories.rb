class AddIsActiveToProviderCategories < ActiveRecord::Migration
  def change
    add_column :provider_categories, :is_active, :boolean
  end
end
