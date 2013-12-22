class CreateUsersExprienceCategoriesTags < ActiveRecord::Migration
  def change
    create_table :users_exprience_categories_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
