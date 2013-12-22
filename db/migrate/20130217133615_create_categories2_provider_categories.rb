class CreateCategories2ProviderCategories < ActiveRecord::Migration
  def change
    create_table :categories2_provider_categories do |t|

      t.belongs_to :categories, :class_name => "Categories"
      t.belongs_to :provider_categories, :class_name => "ProviderCategories"
      t.timestamps
    end
    add_index :categories2_provider_categories, :categories_id
    add_index :categories2_provider_categories, :provider_categories_id
  end
end
