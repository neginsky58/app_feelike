class CreateContentItemFamilyStatuses < ActiveRecord::Migration
  def change
    create_table :content_item_family_statuses do |t|
      t.primary_key :id
      t.string :name

      t.timestamps
    end
  end
end
