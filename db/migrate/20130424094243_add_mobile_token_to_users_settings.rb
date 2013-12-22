class AddMobileTokenToUsersSettings < ActiveRecord::Migration
  def change
    add_column :users_settings, :mobile_token, :string
  end
end
