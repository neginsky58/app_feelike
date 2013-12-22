class CreateUsersExprienceCategories2Tags < ActiveRecord::Migration
  def change
    create_table :users_exprience_categories2_tags do |t|
      t.integer :cat_id
      t.integer :cat_tag_id

      t.timestamps
    end
  end
end
