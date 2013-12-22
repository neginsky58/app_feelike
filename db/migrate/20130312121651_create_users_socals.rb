class CreateUsersSocals < ActiveRecord::Migration
  def change
    create_table :users_socals do |t|
      t.belongs_to :users
      t.boolean :has_twitter
      t.string :twitter_token
      t.boolean :has_facebook
      t.string :facebook_token

      t.timestamps
    end
    add_index :users_socals, :users_id
  end
end
