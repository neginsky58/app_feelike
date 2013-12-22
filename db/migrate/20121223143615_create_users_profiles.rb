class CreateUsersProfiles < ActiveRecord::Migration
  def self.up
    create_table :users_profiles do |t|
      t.string :fname, :null => false
      t.string :lname, :null => false
      t.date :birthDate, :null => false
      t.string :gender, :null => false
      t.belongs_to :image, :class_name => "Assets"
      t.text :bio

      t.belongs_to :user, :class_name => "User", :null => false
      t.belongs_to :family_gender, :class_name => "FamilyGender", :null => false

      t.timestamps
    end
    add_index :users_profiles, :user_id 
    add_index :users_profiles, :family_gender_id 
    add_index :users_profiles, :image_id 
  end
  def self.down
    drop_table :UsersProfiles
  end
end
