class CreateUsersExprience2Categories < ActiveRecord::Migration
  def change
    create_table :users_exprience2_categories do |t|
      t.integer :ue_id
      t.integer :ue_categoy_id

      t.timestamps
    end
  end
end
