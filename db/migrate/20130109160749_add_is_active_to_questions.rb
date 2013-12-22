class AddIsActiveToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :is_active, :boolean
  end

  def self.down
    remove_column :questions, :is_active
  end
end
