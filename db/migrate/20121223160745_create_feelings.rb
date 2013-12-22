class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.primary_key :id
      t.string  :name
      t.string  :hex
      t.integer :sotyBy

      t.timestamps
    end
  end
  def self.down
    drop_table :feelings
  end
end
