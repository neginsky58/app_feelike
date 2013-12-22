class CreateContentItems < ActiveRecord::Migration
  def change
    create_table :content_items do |t|
      t.belongs_to :category, :class_name => "Categorys", :null => false
      t.string :name
      t.text :description, :default => ''
      t.belongs_to :profile_youtube, :class_name => "ContentItemsYoutube", :null => true
      t.belongs_to :profile_itunes, :class_name => "ContentItemsItunes", :null => true
      t.belongs_to :profile_amazon, :class_name => "ContentItemsAmazon", :null => true
      t.belongs_to :profile_faculty, :class_name => "ContentItemsFaculty", :null => true
      t.integer :views, :null => false
      t.integer :shares, :null => false
      t.integer :user_gender, :class_name => "FamilyGenders", :null => true

      t.timestamps
    end
    add_index :content_items, :category_id
    add_index :content_items, :profile_youtube_id
    add_index :content_items, :profile_itunes_id
    add_index :content_items, :profile_amazon_id
    add_index :content_items, :profile_faculty_id
  end
end
