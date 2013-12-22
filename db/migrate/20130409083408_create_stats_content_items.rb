class CreateStatsContentItems < ActiveRecord::Migration
  def change
    create_table :stats_content_items do |t|
      t.integer :item_id
      t.integer :feeling_id
      t.integer :feelike_count
      t.integer :todo_counter
      t.integer :comments_counter
      t.integer :ue_counter
      t.integer :overall_counter

      t.timestamps
    end
  end
end
