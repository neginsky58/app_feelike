class CreateAddAssetIdToUsersContentItems < ActiveRecord::Migration
  def change
    add_column :users_content_items, :asset_id, :integer
  end
end
