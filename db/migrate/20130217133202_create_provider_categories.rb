class CreateProviderCategories < ActiveRecord::Migration
  def change
    create_table :provider_categories do |t|
      t.string :name
      t.string :provider_name
      t.timestamps
    end
  end
end
