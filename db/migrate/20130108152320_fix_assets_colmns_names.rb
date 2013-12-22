class FixAssetsColmnsNames < ActiveRecord::Migration
  def up
  	rename_column :assets, :file_name, :asset_file_name
  	rename_column :assets, :content_type, :asset_content_type
  	rename_column :assets, :file_size, :asset_file_size
  end

  def down
  end
end
