class CreateContentItemAgeRanges < ActiveRecord::Migration
  def change
    create_table :content_item_age_ranges do |t|
    	t.belongs_to :contentItem, :class_name => "ContentItem", :null => false
    	t.belongs_to :ageRange, :class_name => "AgeRanges", :null => false

      t.timestamps
    end
    add_index :content_item_age_ranges, :contentItem_id
    add_index :content_item_age_ranges, :ageRange_id
  end
end
