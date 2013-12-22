class CreateFamilyGenders < ActiveRecord::Migration
  def change
    create_table :family_genders do |t|
      t.primary_key :id
      t.string :name
    end
  end
end
