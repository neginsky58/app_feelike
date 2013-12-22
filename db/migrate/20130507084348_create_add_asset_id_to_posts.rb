class CreateAddAssetIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :asset_id, :integer
  end
end
