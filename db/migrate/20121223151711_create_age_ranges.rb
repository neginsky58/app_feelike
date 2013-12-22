class CreateAgeRanges < ActiveRecord::Migration
  def change
    create_table :age_ranges do |t|
      t.primary_key :id
      t.integer :low
      t.integer :high
    end
  end
end
