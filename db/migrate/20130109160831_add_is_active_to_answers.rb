class AddIsActiveToAnswers < ActiveRecord::Migration
  
	def self.up
    add_column :answers, :is_active, :boolean
  end

  def self.down
    remove_column :answers, :is_active
  end
end
