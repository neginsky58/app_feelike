class CreateUsersExprienceCategories < ActiveRecord::Migration
  def change
    create_table :users_exprience_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
